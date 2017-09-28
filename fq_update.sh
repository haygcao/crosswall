#!/bin/sh
echo
echo " Copyright (c) 2014-2017,by clion007"
echo
echo " 本脚本仅用于个人研究与学习使用，从未用于产生任何盈利（包括“捐赠”等方式）"
echo " 未经许可，请勿内置于软件内发布与传播！请勿用于产生盈利活动！请遵守当地法律法规，文明上网。"
echo
#LOGFILE=/tmp/fq_update.log
#LOGSIZE=$(wc -c < $LOGFILE)
#if [ $LOGSIZE -ge 5000 ]; then
#	sed -i -e 1,10d $LOGFILE
#fi
echo -e "\e[1;36m 1秒钟后开始检测更新脚本及规则\e[0m"
echo
wget --no-check-certificate https://raw.githubusercontent.com/haygcao/crosswall/master/fq_auto.sh -O \
      /tmp/fq_auto.sh && chmod 775 /tmp/fq_auto.sh
wget --no-check-certificate https://raw.githubusercontent.com/haygcao/crosswall/master/fq_update.sh -O \
      /tmp/fq_update.sh && chmod 775 /tmp/fq_update.sh
wget --no-check-certificate https://raw.githubusercontent.com/haygcao/crosswall/master/fqrules_update.sh -O \
      /tmp/fqrules_update.sh && chmod 775 /tmp/fqrules_update.sh
if [ -s "/tmp/fq_auto.sh" ]; then
	if ( ! cmp -s /tmp/fq_auto.sh /etc/dnsmasq/fq_auto.sh ); then
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 检测到新版翻墙脚本......3秒后即将开始更新！"
		echo
		sleep 3
		echo -e "\e[1;36m 开始更新翻墙脚本\e[0m"
		echo
		sh /tmp/fq_auto.sh
		rm -rf /tmp/fq_update.sh
		rm -rf /tmp/fqrules_update.sh
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 翻墙脚本及规则更新完成。"
	elif ( ! cmp -s /tmp/fq_update.sh /etc/dnsmasq/fq_update.sh ); then
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 检测到新版升级脚本......3秒后即将开始更新！"
		echo
		sleep 3
		echo -e "\e[1;36m 开始更新升级脚本\e[0m"
		echo
		sh /tmp/fq_update.sh
		mv -f /tmp/fq_update.sh /etc/dnsmasq/fq_update.sh
		rm -rf /tmp/fq_auto.sh
		rm -rf /tmp/fqrules_update.sh
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 升级脚本更新完成。"
	elif ( ! cmp -s /tmp/fqrules_update.sh /etc/dnsmasq/fqrules_update.sh ); then
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 检测到新版规则升级脚本......3秒后即将开始更新！"
		echo
		sleep 3
		echo -e "\e[1;36m 开始更新规则升级脚本\e[0m"
		echo
		sh /tmp/fqrules_update.sh
		mv -f /tmp/fqrules_update.sh /etc/dnsmasq/fqrules_update.sh
		rm -rf /tmp/fq_auto.sh
		rm -rf /tmp/fq_update.sh
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 规则升级脚本更新完成。"
		else
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 脚本已为最新，3秒后即将开始检测翻墙规则更新"
		sh /etc/dnsmasq/fqrules_update.sh
		rm -rf /tmp/fq_auto.sh
		rm -rf /tmp/fq_update.sh
		rm -rf /tmp/fqrules_update.sh
		echo " `date +'%Y-%m-%d %H:%M:%S'`: 规则已经更新完成。"
	fi	
	else
	echo -e "\e[1;36m  `date +'%Y-%m-%d %H:%M:%S'`: 检查更新失败，请检查网络后再次尝试。\e[0m"
fi
echo
exit 0
