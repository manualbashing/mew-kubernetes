# Setup a local lab on win10

This spins up 3 vms that can be used for practicing to install kubernetes "the hard way".

I used the Vagrantfile from [Kubekloud's repository](https://github.com/kodekloudhub/certified-kubernetes-administrator-course) and adapted it use hyper-v as a provider instead of virtualbox.

The vagrantfile assumes, that there is a virtual switch named "vagrant" configured on Hyper-V, that connects to an exteral network using on of the host's network adapters.

If you don't want that, remove the setting `config.vm.network "public_network", bridge: "vagrant"` from the vagrant file.