using Pkg
Pkg.add(["Pluto", "PlutoUI", "PackageCompiler", "Plots", "Images"])

using PackageCompiler
create_sysimage([:Pluto, :PlutoUI, :Plots, :Images];
    precompile_execution_file="warmup.jl",
    replace_default=true,
    cpu_target=PackageCompiler.default_app_cpu_target()
)
