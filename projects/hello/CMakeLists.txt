cmake_minimum_required(VERSION 3.7.2)

project(hello C)

# Name the executable and list source files required to build it
add_executable( hello 
                src/main.c
                src/uart.c
              )

# List of libraries to link with the application.
target_link_libraries(hello muslc sel4muslcsys)

# Tell the build system that this application is the root task. 
include(rootserver)
DeclareRootserver(hello)

if(SIMULATION)
    include(simulation)
    ApplyCommonSimulationSettings(${KernelSel4Arch})
    GenerateSimulateScript()
endif()