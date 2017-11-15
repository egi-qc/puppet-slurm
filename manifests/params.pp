class slurm::params {
    $slurmd_spool_dir = "/var/spool/slurmd/"
    $state_save_dir   = "/var/spool/slurmctld"
    $control_machine  = "centos-jinja2-deploy" # FIXME hiera
    $control_addr     = "172.16.39.7" # FIXME hiera
    $slurm_ctld_log   = "/var/log/slurmctld.log"
    $slurmd_log       = "/var/log/slurmd.log"
}
