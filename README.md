# PWDFT.jl

`PWDFT.jl` is a package to solve
[electronic structure problems](https://en.wikipedia.org/wiki/Electronic_structure)
based on
[density functional theory](https://en.wikipedia.org/wiki/Density_functional_theory)
(DFT)
and [Kohn-Sham equations](https://en.wikipedia.org/wiki/Kohn%E2%80%93Sham_equations).
It is written in [Julia programming language](https://julialang.org).

The Kohn-Sham orbitals are expanded using plane wave basis. This basis set is
very popular within solid-state community and is also used in several electronic
structure package such as Quantum ESPRESSO, ABINIT, VASP, etc.

## Features

- Total energy calculation of molecules, surfaces, and crystalline system via
  within periodic unit cell.
- SCF with electron density mixing (for semiconducting and metallic systems)
- Direct minimization method using conjugate gradient (for semiconducting systems)
- GTH pseudopotentials (included in the repository)
- LDA-VWN and GGA-PBE functionals (via LibXC)

## Requirements

- [Julia](https://julialang.org/downloads) version >= 0.7:
  with `FFTW` and `SpecialFunctions` packages installed.

## Installation

## Setup `PWDFT.jl` as Julia package

Currently, this package is not yet registered. So, `Pkg.add("PWDFT")` will not work (yet).

We have two alternatives:

1. Using Julia's package manager to install directly from the repository URL:

```julia
Pkg.add(PackageSpec(url="https://github.com/f-fathurrahman/PWDFT.jl"))
```

2. Using Julia development directory. We will use `$HOME/.julia/dev` for this.
   To enable `$HOME/.julia/dev` directory, we need to modify the Julia's
  `LOAD_PATH` variable. Add the following line in your
  `$HOME/.julia/config/startup.jl`.

```julia
push!(LOAD_PATH, expanduser("~/.julia/dev"))
```

  After this has been set, you can download the the package as zip file (using Github) or
  clone this repository to your computer.

  If you download the zip file, extract the zip file under
  `$HOME/.julia/dev$`. You need to rename the extracted directory
  to `PWDFT` (with no `.jl` extension).

  Alternatively, create symlink under `$HOME/.julia/dev`
  to point to you cloned (or extracted) `PWDFT.jl` directory. The link name should not
  contain the `.jl` part. For example:

```bash
ln -fs /path/to/PWDFT.jl $HOME/.julia/dev/PWDFT
```

3. Install PWDFT.jl as local package. Firstly, get into Pkg's REPL mode by tapping `]`, and activate a independent environment `activate .` .

Install the PWDFT.jl package in this environment:

```sh
(PWDFT) pkg> develop <path/to/PWDFT.jl>
```

To make sure that the package is installed correctly, you can load the package
and verify that there are no error messages during precompilation step.
You can do this by typing the following in the Julia console.

```julia
using PWDFT
```

and running unittest in project directory:

```sh
$ julia --project=. -e "using Pkg; Pkg.test()"
```

Change directory to `examples` and run the following in the terminal.

```
julia run.jl "atom_H/main_H_atom.jl"
```

The above command will calculate total energy of hydrogen atom by SCF method.

If you want to use direct minimization method, use the following instead.

```
julia run.jl "atom_H/main_H_atom.jl" Emin
```

## Units

`PWDFT.jl` internally uses Hartree atomic units (energy in Hartree and length in bohr).

## A simple work flow

- create an instance of `Atoms`:

```julia
atoms = Atoms(xyz_file="CH4.xyz", LatVecs=gen_lattice_sc(16.0))
```

- create an instance of `Hamiltonian`:

```julia
ecutwfc = 15.0 # in Hartree
pspfiles = ["../pseudopotentials/pade_gth/C-q4.gth",
            "../pseudopotentials/pade_gth/H-q1.gth"]
Ham = Hamiltonian( atoms, pspfiles, ecutwfc )
```

- solve the Kohn-Sham problem

```julia
KS_solve_SCF!( Ham, betamix=0.2 )  # using SCF (self-consistent field) method
# or
KS_solve_Emin_PCG!( Ham ) # direct minimization using preconditioned conjugate gradient
```

## Band structure calculations

![Band structure of silicon (fcc)](images/bands_Si_fcc.svg)

Please see
[this](examples/bands_Si_fcc/run_bands.jl) as
an example of how this can be obtained.

## Some references

Articles:

- M. Bockstedte, A. Kley, J. Neugebauer and M. Scheffler. Density-functional theory
  calculations for polyatomic systems:Electronic structure, static and elastic properties
  and ab initio molecular dynamics. *Comp. Phys. Commun.* **107**, 187 (1997).

- Sohrab Ismail-Beigi and T.A. Arias. New algebraic formulation of density functional calculation.
  *Comp. Phys. Comm.* **128**, 1-45 (2000)


Books:

- Richard Milton Martin. *Electronic Structure: Basic Theory and Practical Methods*.
  Cambridge University Press, 2004.

- Jorge Kohanoff. *Electronic Structure Calculations for Solids and Molecules:
  Theory and Computational Methods*.
  Cambridge University Press, 2006.

- Dominik Marx and Jürg Hutter. *Ab Initio Molecular Dynamics: Basic Theory and
  Advanced Methods*. Cambridge University Press, 2009.
