base:
  '*':
    - users
    - yum-s3

  'roles:jenkins':
    - match: grain
    - jenkins
    - nginx.jenkins
    - docker
    - packer