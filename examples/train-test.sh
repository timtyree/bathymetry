# Generate the data file lists for training and testing

# Change this to actual directory where the data is downloaded
export DATA_DIR=/home/user/data

# Shuffle segments and create a training & testing set
ls -d $DATA_DIR/JAMSTEC/* | sort -R > all_files.txt
split -l 400 all_files.txt
mv xaa training_files.txt
mv xab testing_files.txt
touch validation_files.txt
mkdir workspace
python -m bathymetry tsv train config.json
python -m bathymetry tsv test-self ./config.json

# the logs are written under ./workspace directory
grep "eval" workspace/testing_log_JAMSTEC.log
# The output should look like
# [0.00032] eval, model_region, data_region, model_size, loss, auprc, auroc, accuracy
# [2.21789] eval, JAMSTEC, JAMSTEC, 1, 0.2801293893848711, 0.9836341882614352, 0.5, 0.9672683765228703
