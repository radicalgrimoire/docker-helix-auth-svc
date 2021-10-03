FROM centos:8
LABEL maintainer "ueno.s <ueno.s@gamestudio.co.jp>"

COPY files/get-keyvault-certificate.sh /opt/perforce/helix-auth-svc/get-keyvault-certificate.sh
COPY files/ecosystem.config.js /opt/perforce/helix-auth-svc/ecosystem.config.js
COPY files/run.sh /usr/local/bin/run.sh

RUN dnf -y install centos-release-stream yum-utils glibc-locale-source cronie sudo glibc-langpack-ja glibc glibc-common tzdata logrotate openssl git \
    && dnf -y swap centos-{linux,stream}-repos \
    && dnf -y distro-sync \
    && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial \
    && dnf -y upgrade \
    && dnf -y update \
    && cd /lib/systemd/system/sysinit.target.wants/ && \
    for i in *; do \
        [ $i == systemd-tmpfiles-setup.service ] || rm -vf $i ; \
    done ; \
    rm -vf /lib/systemd/system/multi-user.target.wants/* && \
    rm -vf /etc/systemd/system/*.wants/* && \
    rm -vf /lib/systemd/system/local-fs.target.wants/* && \
    rm -vf /lib/systemd/system/sockets.target.wants/*udev* && \
    rm -vf /lib/systemd/system/sockets.target.wants/*initctl* && \
    rm -vf /lib/systemd/system/basic.target.wants/* && \
    rm -vf /lib/systemd/system/anaconda.target.wants/* && \
    mkdir -p /etc/selinux/targeted/contexts/ && \
    echo '<busconfig><selinux></selinux></busconfig>' > /etc/selinux/targeted/contexts/dbus_contexts \
    && dnf clean all --enablerepo='*' \
    && dnf clean metadata --enablerepo='*' \
    && dnf clean all --enablerepo='*' \
    && rm -rf /var/cache/yum \
    && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 \
    && localedef -i /usr/share/i18n/locales/ja_JP -f UTF-8 /usr/lib/locale/ja_JP.UTF-8 \
    && sed -i -e '/override_install_langs/s/$/,ja_JP.utf8/g' /etc/locale.conf \
    && source /etc/locale.conf \
    && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && rpm --import https://package.perforce.com/perforce.pubkey \
    && yum-config-manager --add-repo https://gist.githubusercontent.com/hexagrimoire/f235f327baacdf6f109903eec5d9a717/raw/f54bb09d6a73d390762feaf0ef3344d128677dc9/perforce.centos.repo \
    && dnf install -y tzdata logrotate sudo which cronie openssl curl git gcc-c++ make \
    && curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash - \
    && sudo sed -i -e "/^failovermethod=/d" /etc/yum.repos.d/*.repo \
    && systemctl enable crond \
    && sudo dnf -q -y install nodejs \
    && sudo npm install -g pm2 \
    && sudo dnf -y install helix-auth-svc \
    && bash run.sh

EXPOSE 3000

ENV LANG="ja_JP.UTF-8" \
    LC_ALL="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja"

ENTRYPOINT ["run.sh"]

CMD [ "/sbin/init" ]

