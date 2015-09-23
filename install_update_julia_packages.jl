#!/usr/bin/env julia
#
# Title: Julia Packages Installation
# Description: Install All Julia Packages that I use.
# Tags: Programming Language, Julia, Package
#

using Base.Pkg
Pkg.update()
Pkg.add("DataFrames")
Pkg.add("PyCall")
Pkg.add("Requests.jl")
