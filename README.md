# Oracle Databse Free docker container on M1 Mac (ARM)

Oracle does not provide a native M1 Mac version of their docker image. We will use the offical [Oracle Database Free](https://www.oracle.com/database/free/get-started/) that only provides docker images build for `linux/amd64`.

This is a workaround to run the container on M1 Macs. It uses [colima](<https://github.com/abiosoft/colima>) to run the container in a virtual machine.

If you are using an Intel Mac or linux you can skip the colima setup and use the docker image directly.

## Setup colima

### Install

```bash
brew install colima
```

### Start

```bash
colima start --arch x86_64 --vm-type=vz --vz-rosetta --mount-type virtiofs --memory 4
```

### Stop

```bash
colima stop
```

### Remove

```bash
colima delete
```

## Start docker container

### Use the colima context that is will be started by colima

```bash
docker context use colima
```

### Start the container

```bash
docker run -d --name oracle-local -p 1521:1521 container-registry.oracle.com/database/free:latest
```

or use the `docker-compose.yml` file

```bash
docker-compose up -d
```

## Connect to database

### Connect with sqlplus

```bash
docker exec -it oracle-local bash -c "sqlplus /nolog"
```

### Login as sysdba

```sql  
conn / as sysdba
alter session set "_ORACLE_SCRIPT"=true;  
```

### Create user and grant privileges

```sql  
create user testuser identified by testuser quota unlimited on users;
grant connect,
    resource to testuser;
grant create session to testuser;
grant unlimited tablespace to testuser;
grant db_developer_role to testuser;
grant execute on dbms_debug_jdwp to testuser;
```

### Delete user

```sql
drop user testuser cascade;
```

### Connect with user

```bash
docker exec -it oracle-local bash -c "source /home/oracle/.bashrc; sqlplus testuser/testuser"
```

### Datagrip setup

![datagrip setup](datagrip.png)
