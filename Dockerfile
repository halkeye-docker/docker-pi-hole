FROM pihole/pihole:latest

#update and accept all prompts
RUN echo 'APT::Default-Release "stretch";' > /etc/apt/apt.conf.d/99defaultrelease \
      && echo 'Dpkg::Options { "--force-confdef"; "--force-confold"; };' > /etc/apt/apt.conf.d/50unattended-upgrades \
      && cat /etc/apt/sources.list | perl -p -e 's/stretch|stable/testing/' > /etc/apt/sources.list.d/testing.list \
      && apt-get update -y \
      && apt-get dist-upgrade -y \
      && apt-get install -y -t testing dnsmasq libnettle6 \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*
