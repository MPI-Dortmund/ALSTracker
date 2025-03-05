# Bayesian ALS Tracking and Phase Evaluation

If you would like to try the ALSTracker, we host it at the MPI Dortmund:

https://alstracker.mpi-dortmund.mpg.de/

## How to install your own server (Ubuntu)

1. Install a linux, e.g. Ubuntu
2. Install nginx `apt install nginx`
3. Install supervisorctl `apt install supervisorctl`
4. Download and unzip mogp model: https://fraenkel.mit.edu/mogp/
4. Download and install miniconda
    - `curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"`
    - `bash Miniforge3-$(uname)-$(uname -m).sh`
    - `~/miniforge3/bin/conda init`
7. Clone this repository `git clone https://github.com/MPI-Dortmund/ALSTracker`
8. cd ALSTracker
9. Create a new conda environment
    - `conda env create -f ./conda.yaml`
10. Adjust the variables `RUN_DIR`, `MINICONDA_DIR`, `VENV`, `ALSTRACKER_MOGP` based on the decisions in the previous steps in `gunicorn_start.sh`
11. Adjust the `command`, `stdout_logfile`, `user` variables in `als_tracker.conf.template`
12. Copy or link the `als_tracker.conf.template` to `/etc/supervisor/conf.d`
    - `sudo ln -s $(realpath als_tracker.conf.template) /etc/supervisor/conf.d/als_tracker.conf`
13. Start the tracker
    - `sudo supervisorctl start als_tracker`
14. Adjust the variables `XXX_RUN_DIR_XXX`, `XXX_LOG_DIR_XXX`, `XXX_SERVERNAME_XXX` in the nginx.template
    - Make sure that the `XXX_LOG_DIR_XXX` directory is writable for the `www-data` group.
15. Copy or link the `nginx.template` to `/etc/nginx/sites-enabled`
    - `sudo ln -s $(realpath nginx.template) /etc/nginx/sites-enabled/als_tracker.site`
16. Get a certificate for the SERVERNAME (This should alter your als_tracker.site file)
    - `sudo snap install certbot`
    - `sudo certbot --nginx`
16. Restart nginx
    - `sudo systemctl restart nginx`
