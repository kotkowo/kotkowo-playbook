# Deploy
## Install requirements

``` sh
ansible-galaxy install -r requirements.yml
```

## Generate secret_key_base

``` sh
mix phx.gen.secret
```

### Put the key in the vault

``` sh
ansible-vault create group_vars/all.yml
```

Put the key like this:

``` yaml
secret_key_base: |
   <PASTE YOUR KEY HERE>
```

## Setup your host

Go into `hosts.yml` and put your host there

``` yaml
all:
  children:
    dokku:
      hosts:
        your_host_name:
          ansible_host: your_host_url_or_ip_address
          ansible_user: root
```

## Run the playbook

``` sh
ansible-playbook dokku.yml -i hosts.yml --ask-vault-pass
```
