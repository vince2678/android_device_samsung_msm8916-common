/*
 * Copyright (C) 2016 The CyanogenMod Project
 * Copyright (C) 2018 The LineageOS  Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#define LOG_TAG "PowerHAL"

#include <hardware/hardware.h>
#include <hardware/power.h>

#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>

#include <utils/Log.h>

#include "power.h"

#define CPUFREQ_PATH "/sys/devices/system/cpu/cpu0/cpufreq/"
#define INTERACTIVE_PATH "/sys/devices/system/cpu/cpufreq/interactive/"

static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

static int current_power_profile = PROFILE_BALANCED;

static int sysfs_write_str(char *path, char *s)
{
    char buf[80];
    int len;
    int ret = 0;
    int fd;

    fd = open(path, O_WRONLY);
    if (fd < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error opening %s: %s\n", path, buf);
        return -1 ;
    }

    len = write(fd, s, strlen(s));
    if (len < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error writing to %s: %s\n", path, buf);
        ret = -1;
    }

    close(fd);

    return ret;
}

static int sysfs_write_int(char *path, int value)
{
    char buf[80];
    snprintf(buf, 80, "%d", value);
    return sysfs_write_str(path, buf);
}

static int is_profile_valid(int profile)
{
    return profile >= 0 && profile < PROFILE_MAX;
}

static void power_init(__attribute__((unused)) struct power_module *module)
{
    ALOGI("%s", __func__);
}

static void set_power_profile(__attribute__((unused)) struct power_module *module, int on)
{

    ALOGD("%s: setting profile %d", __func__, profile);

    sysfs_write_int(INTERACTIVE_PATH "go_hispeed_load",
                    profiles[current_power_profile].go_hispeed_load);
    sysfs_write_int(INTERACTIVE_PATH "hispeed_freq",
                    profiles[current_power_profile].hispeed_freq);
    sysfs_write_int(INTERACTIVE_PATH "min_sample_time",
                    profiles[current_power_profile].min_sample_time);
    sysfs_write_int(INTERACTIVE_PATH "timer_rate",
                    profiles[current_power_profile].timer_rate);
    sysfs_write_int(INTERACTIVE_PATH "above_hispeed_delay",
                    profiles[current_power_profile].above_hispeed_delay);
    sysfs_write_int(INTERACTIVE_PATH "target_loads",
                    profiles[current_power_profile].target_loads);
    sysfs_write_int(CPUFREQ_PATH "scaling_max_freq",
                    profiles[current_power_profile].scaling_max_freq);
    sysfs_write_int(CPUFREQ_PATH "scaling_min_freq",
                    profiles[current_power_profile].scaling_min_freq);
}

static void power_set_interactive(__attribute__((unused)) struct power_module *module, int on)
{

    if (on) {
        sysfs_write_int(INTERACTIVE_PATH "hispeed_freq",
                        profiles[current_power_profile].hispeed_freq);
        sysfs_write_int(INTERACTIVE_PATH "go_hispeed_load",
                        profiles[current_power_profile].go_hispeed_load);
        sysfs_write_int(INTERACTIVE_PATH "target_loads",
                        profiles[current_power_profile].target_loads);
        sysfs_write_int(CPUFREQ_PATH "scaling_min_freq",
                        profiles[current_power_profile].scaling_min_freq);
    } else {
        sysfs_write_int(INTERACTIVE_PATH "hispeed_freq",
                        profiles[current_power_profile].hispeed_freq_off);
        sysfs_write_int(INTERACTIVE_PATH "go_hispeed_load",
                        profiles[current_power_profile].go_hispeed_load_off);
        sysfs_write_int(INTERACTIVE_PATH "target_loads",
                        profiles[current_power_profile].target_loads_off);
        sysfs_write_int(CPUFREQ_PATH "scaling_min_freq",
                        profiles[current_power_profile].scaling_min_freq_off);
    }
}

static void power_hint(__attribute__((unused)) struct power_module *module,
                       power_hint_t hint, void *data)
{
    char buf[80];
    int len;

    switch (hint) {
        break;
    case POWER_HINT_LOW_POWER:
        /* This hint is handled by the framework */
        break;
    default:
        break;
    }
}

static int power_open(const hw_module_t* module, const char* name,
                    hw_device_t** device)
{
    ALOGD("%s: enter; name=%s", __FUNCTION__, name);

    if (strcmp(name, POWER_HARDWARE_MODULE_ID)) {
        return -EINVAL;
    }

    power_module_t *dev = (power_module_t *)calloc(1,
            sizeof(power_module_t));

    if (!dev) {
        ALOGD("%s: failed to allocate memory", __FUNCTION__);
        return -ENOMEM;
    }

    dev->common.tag = HARDWARE_MODULE_TAG;
    dev->common.module_api_version = POWER_MODULE_API_VERSION_0_2;
    dev->common.hal_api_version = HARDWARE_HAL_API_VERSION;

    dev->init = power_init;
    dev->powerHint = power_hint; // This is handled by framework
    dev->setPowerProfile = set_power_profile;
    dev->setInteractive = power_set_interactive;

    *device = (hw_device_t*)dev;

    ALOGD("%s: exit", __FUNCTION__);

    return 0;
}

static struct hw_module_methods_t power_module_methods = {
    .open = power_open,
};

struct power_module HAL_MODULE_INFO_SYM = {
    .common = {
        .tag = HARDWARE_MODULE_TAG,
        .module_api_version = POWER_MODULE_API_VERSION_0_2,
        .hal_api_version = HARDWARE_HAL_API_VERSION,
        .id = POWER_HARDWARE_MODULE_ID,
        .name = "msm8916 Power HAL",
        .author = "The LineageOS Project",
        .methods = &power_module_methods,
    },

    .init = power_init,
    .setPowerProfile = set_power_profile,
    .setInteractive = power_set_interactive,
    .powerHint = power_hint
};
