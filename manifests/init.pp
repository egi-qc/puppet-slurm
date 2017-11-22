
class slurm inherits slurm::params {

    Class[slurm::install] -> Class[slurm::config]

    class { "slurm::install": }
    class { "slurm::config": }

}

class slurm::install {
    if $::osfamily == "RedHat" {
        package {
            ["munge", "munge-libs"]:
                ensure => installed
        }

        exec {
            "Install slurm RPMs":
                command => "/usr/bin/rpm -ivh https://depot.galaxyproject.org/yum/el/7/x86_64/slurm-plugins-17.02.6-1.el7.centos.x86_64.rpm https://depot.galaxyproject.org/yum/el/7/x86_64/slurm-17.02.6-1.el7.centos.x86_64.rpm https://depot.galaxyproject.org/yum/el/7/x86_64/slurm-munge-17.02.6-1.el7.centos.x86_64.rpm",
                require => Package["munge", "munge-libs"]
        }
    }
}

class slurm::config {
    $slurmd_spool_dir = $slurm::params::slurmd_spool_dir
    $state_save_dir   = $slurm::params::state_save_dir
    $control_machine  = $slurm::params::control_machine
    $control_addr     = $slurm::params::control_addr
    $slurm_ctld_log   = $slurm::params::slurm_ctld_log
    $slurmd_log       = $slurm::params::slurmd_log
    file {
        "/etc/slurm/slurm.conf":
            content => template("slurm/slurm.conf.erb")
    }

    file {
        "/var/spool/slurmd":
            ensure => directory,
            owner  => slurm,
            mode   => 0755
    }

    file {
        "/var/log/slurmd.log":
            ensure => present,
            owner  => slurm,
    }

    file {
        "/var/spool/slurmctld":
            ensure => directory,
            owner  => slurm,
            mode   => 0755
    }

    file {
        "/var/log/slurmctld.log":
            ensure => present,
            owner  => slurm,
    }
}
