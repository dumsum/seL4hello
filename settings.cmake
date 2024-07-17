cmake_minimum_required(VERSION 3.7.2)

set(project_dir "${CMAKE_CURRENT_LIST_DIR}")
file(GLOB project_modules ${project_dir}/projects/*)
list(
    APPEND
        CMAKE_MODULE_PATH
        ${project_dir}/kernel
        ${project_dir}/tools/cmake-tool/helpers/
        ${project_dir}/tools/elfloader-tool/
        ${project_modules}
)

set(SEL4_CONFIG_DEFAULT_ADVANCED ON)
set(SIMULATION ON CACHE BOOL "Include only simulation compatible tests")
set(RELEASE OFF CACHE BOOL "Performance optimized build")
set(VERIFICATION OFF CACHE BOOL "Only verification friendly kernel features")
set(BAMBOO OFF CACHE BOOL "Enable machine parseable output")
set(DOMAINS OFF CACHE BOOL "Test multiple domains")
set(SMP OFF CACHE BOOL "(if supported) Test SMP kernel")
set(NUM_NODES "" CACHE STRING "(if SMP) the number of nodes (default 4)")
set(PLATFORM "rpi3" CACHE STRING "Platform to test")
set(AARCH64 ON CACHE BOOL "")
set(ARM_HYP OFF CACHE BOOL "Hyp mode for ARM platforms")
set(MCS ON CACHE BOOL "MCS kernel")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(application_settings)
correct_platform_strings()
ApplyData61ElfLoaderSettings(${KernelPlatform} ${KernelSel4Arch})

find_package(seL4 REQUIRED)
ApplyCommonReleaseVerificationSettings(${RELEASE} ${VERIFICATION})
