set(LIB_NAME nghttp2)
set(LIB_VERSION 1.39.2)

set(LIB_FILENAME ${LIB_NAME}-${LIB_VERSION}.tar.gz)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nghttp2/nghttp2
    REF v${LIB_VERSION}
    SHA512 1ddfb8c6538e209e39199fb5e2f9c262d58d188f25c98cd03f9f733bb261055b7625f0f79863731b112e69bc40c9d6a7d10d4fe69f56c615127e03277ee3af1d
    HEAD_REF master
)

if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
    set(ENABLE_STATIC_LIB ON)
    set(ENABLE_SHARED_LIB OFF)
else()
    set(ENABLE_STATIC_LIB OFF)
    set(ENABLE_SHARED_LIB ON)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DENABLE_LIB_ONLY=ON
        -DENABLE_ASIO_LIB=OFF
        -DENABLE_STATIC_LIB=${ENABLE_STATIC_LIB}
        -DENABLE_SHARED_LIB=${ENABLE_SHARED_LIB}
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/man)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/doc)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

vcpkg_copy_pdbs()
