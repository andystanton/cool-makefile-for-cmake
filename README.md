# Cool Makefile for CMake Projects

A Makefile that makes configuring and building CMake projects really simple.

## Usage

Drop the `Makefile` into a directory containing a `CMakeLists.txt`, and run `make` to configure and build the project.

Alternatively, if you place the `Makefile` into a directory that does not contain a `CMakeLists.txt` and execute the init, configure, build, install, or run targets, you will be prompted for a project name and language (C or C++) for the creation of a skeleton CMake project.

## Examples

Configure and build the project described by the CMakeLists.txt in the current directory, using Ninja (or Unix Makefiles if Ninja is unavailable) as the CMake generator with a build type of `debug`:

```sh
make
```

Configure, build, and run the project described by the CMakeLists.txt in the current directory, using Xcode as the CMake generator with a build type of `release`:

```sh
make generator=Xcode type=release run
```

Initialise a skeleton CMake project with an example C source file:

```sh
make project_name=foo project_lang=c cmake_min_version=3.5 init
```

## Targets

- `make help`: lists the supported targets.
- `make init`: initialises a skeleton CMake project if there is no CMakeLists.txt in the current directory.
- `make configure`: configures the build system for the selected generator.
- `make build`: executes the build for the configured build system.
- `make install`: executes the installation step (if any) for the configured build system.
- `make run`: tries to run the project by calling the name of the last `add_executable` entry.
- `make clean`: cleans the build directory for the active generator and build type.
- `make clean-all`: cleans the build directories for all generators and build types.

### Target dependencies

- The default target is `build`.
- `run` and `install` depend on `build`.
- `build` depends on `configure`.
- `configure` depends on `init`.

## Variables

- `type`: the CMake build type. Valid types are Release, Debug, RelWithDebInfo, and MinSizeRel. Default is Debug.
- `generator`: the CMake generator to use. Supported generators are 'Ninja', 'Unix Makefiles', and 'Xcode'. Default is Ninja if the ninja executable is on the path, and Unix Makefiles if not.
- `build_path`: allows overriding of the build path. Defaults to `cmake-build-$type` for 'Ninja' & 'Unix Makefiles' generators, and `xcode-build` for Xcode.

### Variables that apply only to the init target

- `project_name`: if supplied then the init target will not prompt for a project name.
- `project_lang`: if supplied then the init target will not prompt for a project language. Valid languages are 'c' and 'cpp'. Default value is 'c'.
- `cmake_min_version`: if supplied then the init target will not prompt for a CMake minimum version. Default value is 3.5.

## Dependencies

- Make
- CMake
- sh, egrep, sed, column, sort, head

## Limitations

- The Makefile is suitable for simple projects.
- Not all CMake supported generators and platforms are supported by this Makefile.
- Definitions of cool may vary.

## Testing

The tests execute in a Debian Docker container and can be run as follows:

```sh
test/run-tests.sh
```

