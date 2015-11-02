## TypeChef setup for linux/tools/perf

Copy .pc files from pcs directory to the folder with the source code

This project assumes a directory (possibly a symbolic link) to the
source code of the kernel repository at "linux"

It also assumes TypeChef in a directory ../TypeChef with a generated
typechef.sh file in that directory (call `sbt mkrun`)

Currently, there is only a rudementary setup. Update `open` with a list
of open features that should be considered as symbolic. Update `filelist`
if additional files should be considered. Update `featureModel` if
additional constraints are enforced by KConfig or KBuild. Update 
`buildextras.sh` if certain files receive extra parameters. Update
`partialConf.h` to define additional global macros.
