# Stellarscope bug reproduce

It seems that different runs of stellarscope on the same data are giving different results.


### TO REPRODUCE

##### setup environment

```
mamba env create -n stbug environment.yml
conda activate stbug
```

##### pull the latest stellarscope, devmode branch

```
git clone git@github.com:nixonlab/stellarscope.git stellarscope_devmode.git
git fetch
git switch -c devmode origin/devmode
git rev-parse --short HEAD
```

The commit should be `520b379`

##### install stellarscope into stbug environment

```
pip install -e .
cd ..
```

##### run the test script twice

the test script includes the commit hash in the output directory name and handles creating a new output directory when the current one exists. 

```
. runtest1.sh
. runtest1.sh
```

##### final outputs are different


```
diff -q output.520b379.rep?/pseudobulk-TE_counts.mtx
```

Output:

```
Files output.520b379.rep1/pseudobulk-TE_counts.mtx and output.520b379.rep2/pseudobulk-TE_counts.mtx differ
```

##### Check intermediate results

The `--devmode` setting outputs several intermediate matrices that can be compared between runs.

```
diff output.520b379.rep?/pseudobulk-rawscores_before_fit.txt
diff output.520b379.rep?/pseudobulk-rawscores_after_fit.txt
diff output.520b379.rep?/pseudobulk-probs_after_fit.txt
diff output.520b379.rep?/pseudobulk-assignments_exclude.txt
```

