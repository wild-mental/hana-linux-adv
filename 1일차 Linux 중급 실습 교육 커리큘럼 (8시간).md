좋아, 중급 수준의 참가자들을 대상으로 한 1일 8시간 실습 중심의 리눅스 교육안을 작성할게. VirtualBox와 MobaXterm을 활용해 Windows 환경에서 실습하는 방식이며, 시간대별 커리큘럼과 함께 도구 사용 절차까지 포함된 Markdown(.md) 파일 형식으로 구성할게. 준비되면 교육안 파일을 제공하겠어.


# 1일차 Linux 중급 실습 교육 커리큘럼 (8시간)

## 09:00–10:00: 수업 환경 구성 (VirtualBox, Rocky Linux 9.4 ISO, MobaXterm 설치)

**이론:** Windows 환경에서 Linux 가상머신을 활용한 실습을 진행합니다. Oracle VM VirtualBox를 사용하여 Rocky Linux 9.4 가상 머신(VM)을 생성하고, Windows에서 MobaXterm 터미널을 통해 VM에 접속합니다. 이를 위해 필요한 도구(가상화 소프트웨어, ISO 이미지, SSH 클라이언트)를 설치하고 준비합니다.

**실습:** 다음 단계에 따라 실습 환경을 구축합니다.

1. **Oracle VirtualBox 설치** – VirtualBox는 x86 가상화 소프트웨어로, 윈도우에서 리눅스 VM을 구동할 수 있게 해줍니다. Oracle VirtualBox [공식 다운로드 페이지](https://www.virtualbox.org/wiki/Downloads)에서 Windows 용 최신 버전을 내려받아 기본 설정대로 설치하세요. 설치 완료 후 VirtualBox를 실행합니다. (문제 발생 시: BIOS에서 가상화 기술(VT-x/AMD-V)이 활성화되어 있는지 확인하세요.)

2. **Rocky Linux 9.4 ISO 다운로드** – Rocky Linux는 RHEL과 호환되는 엔터프라이즈 Linux 배포판입니다. Rocky Linux [공식 홈페이지](https://rockylinux.org)에서 **Rocky Linux 9.4 (x86\_64) DVD ISO** 이미지를 다운로드합니다. (※ 최신 버전 9.5가 표시될 경우 9.4 ISO를 선택하거나 제공된 9.4 ISO 링크를 사용하십시오.) ISO 파일은 예를 들어 `Rocky-9.4-x86_64-dvd.iso` 형태의 이름입니다. 다운로드한 ISO의 위치를 기억해둡니다.

3. **MobaXterm 설치** – MobaXterm은 Windows용 터미널 에뮬레이터/SSH 클라이언트입니다. [MobaXterm Home Edition 다운로드](https://mobaxterm.mobatek.net/download-home-edition.html) 페이지에서 최신 버전을 받아 설치합니다 (포터블 버전 사용 가능). MobaXterm을 사용하면 Windows에서 손쉽게 SSH로 리눅스 서버에 접속하고 명령줄을 사용할 수 있습니다.

4. **VirtualBox 네트워크 어댑터 설정 확인** – VirtualBox에서 VM을 생성하기 전에 **호스트 전용 어댑터(Host-Only)** 기능이 설정되어 있어야 합니다. VirtualBox 관리자에서 **File > Host Network Manager** 메뉴를 열어 `vboxnet0` 호스트전용 네트워크가 존재하고 DHCP 서버가 활성화되어 있는지 확인합니다 (기본값: IP 대역 192.168.56.0/24, 호스트 IP 192.168.56.1). 없을 경우 **Create** 버튼으로 생성하세요. 이 호스트전용 네트워크는 나중에 VM과 호스트 PC(Windows) 간 통신에 사용됩니다.

## 10:00–11:00: Rocky Linux 9.4 가상 머신 생성 및 운영체제 설치

**이론:** VirtualBox를 통해 Rocky Linux 9.4 VM을 생성하고 운영체제를 설치합니다. VM 생성 시 메모리, 디스크를 적절히 할당하고, 네트워크 설정으로 NAT와 호스트전용 어댑터 두 가지를 사용합니다. NAT(Network Address Translation)는 VM의 인터넷 접속(패키지 설치 등)을 위해 사용하고, 호스트전용 어댑터는 호스트(Windows)와 VM 간 직접 통신(SSH 접속 등)을 위해 사용합니다. 설치 과정에서 Root 비밀번호 및 사용자 계정을 생성하고, SSH 접속을 위해 필요한 설정을 확인합니다.

**실습:** 다음 단계를 따라 Rocky Linux VM을 만들어 OS를 설치합니다.

1. **새 VM 생성** – VirtualBox를 열고 **New(새로 만들기)** 버튼을 클릭합니다.

   * 이름: `RockyLinux9` (원하는 이름 설정 가능)
   * 유형(Type): **Linux**, 버전(Version): **Red Hat (64-bit)**
   * 메모리: **2048 MB (2GB)** 이상 권장.
   * 가상 하드 디스크: **동적 할당 VDI**, 크기 **20GB** 이상 생성.

2. **네트워크 어댑터 구성** – 방금 만든 VM을 선택하고 \*\*설정(Settings) > 네트워크(Network)\*\*로 이동합니다.

   * 어댑터 1: **NAT** (기본값).
   * 어댑터 2: **호스트 전용 어댑터**로 활성화하고, 이름을 앞서 확인한 호스트전용 네트워크(vboxnet0 등)로 설정합니다. (케이블 연결됨(Connected) 옵션 체크 확인)

3. **ISO 이미지 연결** – \*\*설정 > 저장소(Storage)\*\*에서 컨트롤러의 Empty 광학 드라이브를 선택한 후, **디스크 이미지 선택**을 클릭하여 이전에 다운로드한 Rocky Linux 9.4 ISO 파일을 연결합니다. (IDE 컨트롤러 또는 SATA Controller의 Optical Drive에 ISO 마운트)

4. **설치 시작** – VM을 \*\*시작(Start)\*\*합니다. Rocky Linux ISO로 부팅되면 **Install Rocky Linux 9** 메뉴를 선택하여 설치를 진행합니다.

   * 언어 선택: 기본값 **English** (혹은 한국어 선택 가능).
   * 설치 소프트웨어 선택: **Minimal Install** 또는 \*\*Server (CLI)\*\*를 선택 (GUI 불필요).
   * 파티션: **자동 파티션**으로 둡니다 (기본값).
   * **네트워크 & 호스트명(Network & Hostname)**: 첫번째 이더넷(enp0s3, NAT)을 **Connected(연결)** 상태로 켜고, 호스트네임을 예시로 `server1`로 설정합니다. (호스트네임은 추후 식별을 위해 VM마다 다르게 지정할 예정입니다.)
   * **Root 암호**: 관리자 계정(root)의 비밀번호를 지정합니다.
   * **일반 사용자 생성**: 예시로 사용자 `student`를 생성하고 **Administrators 그룹 포함**(sudo권한 부여) 옵션을 체크합니다. (원한다면 생략 가능하고 root만으로 진행해도 무방하나, 보안상 사용자 계정으로 접속 권장)

5. **OS 설치 진행** – 위 설정을 확인하고 \*\*Begin Installation(설치 시작)\*\*을 클릭합니다. 설치가 완료될 때까지 기다렸다가 **Reboot(재부팅)** 버튼을 눌러 시스템을 재시작합니다. ISO가 계속 연결되어 있으면 설치 과정이 다시 시작될 수 있으므로, 재부팅 시 **Devices > Optical Drives**에서 Rocky ISO 연결을 해제하거나 부팅 메뉴에서 VM의 디스크를 선택하세요.

6. **첫 부팅 및 로그인** – 재부팅 후 Rocky Linux 로그인 프롬프트가 나타나면, root 또는 생성한 사용자 계정으로 로그인합니다. (root로 직접 로그인하려면 설치 시 설정한 root 암호 사용. 일반 사용자로 로그인한 경우 `sudo -i`로 root 전환 가능.)

**문제 해결:** 만약 VM이 부팅되지 않거나 커널 패닉 등의 메시지가 나온다면, VM 설정에서 ISO 연결 여부, 저장소 컨트롤러 종류 등을 확인합니다. 설치 중 디스크 파티셔닝 오류가 발생하면 디스크 용량을 늘리거나 기존 VM을 삭제하고 다시 시도합니다. 또한 호스트 PC의 메모리가 부족할 경우 VM 메모리를 조정하거나 실행 중인 다른 프로그램을 종료합니다.

## 11:00–12:00: 가상 머신 초기 설정 및 SSH 원격 접속

**이론:** Rocky Linux 설치 직후 기본 설정을 수행합니다. 네트워크 인터페이스를 확인하고 IP 주소를 파악한 뒤, Windows 호스트에서 MobaXterm으로 SSH 접속을 설정합니다. VirtualBox NAT 어댑터를 통해 인터넷 연결을 확인하고, 호스트전용 어댑터를 통해 호스트-PC와 통신할 수 있도록 네트워크 설정을 조정합니다. 또한 시스템 업데이트와 패키지 설치를 위한 기본 명령어를 다룹니다.

**실습:** 다음 단계를 통해 Rocky Linux 초기 설정과 원격 접속을 수행합니다.

1. **네트워크 인터페이스 확인** – VM 콘솔(또는 VirtualBox 창)에서 `ip addr` 명령을 실행하여 네트워크 인터페이스를 확인합니다. 기본적으로 NAT에 해당하는 `enp0s3` 인터페이스는 DHCP로 **10.0.2.x** 대역 IP를 받았을 것입니다. 호스트전용 `enp0s8` 인터페이스는 현재 \*\*IP 할당이 안 된 상태( DOWN )\*\*일 수 있습니다.

   ```bash
   ip addr
   ```

   `enp0s3`의 IP (`inet 10.0.2.15/24` 등)와 `enp0s8` (이 경우 `state DOWN` 또는 아예 없음)를 확인합니다.

2. **호스트전용 네트워크 IP 구성** – 호스트전용 어댑터 `enp0s8`에 IP를 설정합니다. DHCP를 사용하거나, 고정 IP를 수동으로 할당할 수 있습니다. 여기서는 \*\*고정 IP(static IP)\*\*를 설정해 보겠습니다. 우선 NetworkManager의 명령줄 도구 nmcli를 사용해 현재 연결들을 확인합니다:

   ```bash
   nmcli connection show
   ```

   출력에 `Wired connection 1` (enp0s3용)와 `Wired connection 2` (enp0s8용)가 보일 수 있습니다. 이제 `Wired connection 2` 프로파일에 고정 IP를 설정하고 자동 연결되도록 수정합니다. 예를 들어 VM의 호스트전용 IP를 **192.168.56.101**로 정하겠습니다.

   ```bash
   sudo nmcli connection modify "Wired connection 2" ipv4.method manual ipv4.addresses 192.168.56.101/24 connection.autoconnect yes
   sudo nmcli connection up "Wired connection 2"
   ```

   *설명:* 위 명령으로 `enp0s8`에 192.168.56.101/24 IP를 수동 설정하고, 연결을 활성화하였습니다. 이제 `ip addr`로 확인하면 `enp0s8`에 IP가 적용된 것을 볼 수 있습니다. (만약 `Wired connection 2` 프로파일이 없다면, `sudo nmcli connection add type ethernet ifname enp0s8 con-name hostonly ipv4.method manual ipv4.addresses 192.168.56.101/24` 명령으로 새 연결을 추가할 수도 있습니다.)

3. **고정 IP 설정 유지** – 서버 가상머신을 종료 후 재시작했을 경우에도 수동 IP 지정 설정이 유지되도록 하기 위해, 다음 명령을 사용하여 기존 DHCP 설정을 완전히 오버라이드합니다:

   ```bash
   sudo nmcli connection down enp0s8
   sudo nmcli connection modify enp0s8 ipv4.method manual
   sudo nmcli connection modify enp0s8 ipv4.addresses 192.168.56.[101~103]/24
   sudo nmcli connection modify enp0s8 ipv4.gateway 192.168.56.2 ipv4.dns 8.8.8.8
   sudo nmcli connection up enp0s8
   ```

   이 명령은 `hanafn-s2`, `hanafn-s3`에 대해 DHCP를 사용하게 설정된 기존 설정을 완전히 오버라이드하여 수동 IP 설정을 적용합니다.

4. **문제 해결: 인터페이스가 관리되지 않는 경우**

   `ip addr`에는 보이는데 `nmcli connection show`나 `nmcli conn modify`에서 보이지 않는 경우, 가장 먼저 의심해봐야 할 것은 **NetworkManager가 해당 인터페이스를 "관리 대상(unmanaged)"으로 인식하고 있다**는 점입니다.

   * **nmcli device status** 로 확인해 보세요.

     ```bash
     nmcli device status
     ```

     출력에서 `enp0s8`의 STATE가 `unmanaged`로 나온다면, NM이 이 장치를 관리하지 않으므로 연결 프로파일이 생성되지 않습니다.

   * **원인**

     1. `/etc/NetworkManager/NetworkManager.conf` 에서 `unmanaged-devices=` 설정으로 호스트전용(Host-Only) 어댑터를 제외해 두었거나
     2. `/etc/sysconfig/network-scripts/ifcfg-enp0s8` 파일에 `NM_CONTROLLED=no` 옵션이 지정되어 있거나
     3. NetworkManager의 keyfile/network-scripts 플러그인 설정이 바뀌어서 해당 장치에 대한 프로파일 자동생성이 비활성화된 경우

   * **해결 방법**

     1. **관리 대상으로 전환**

        ```bash
        sudo nmcli device set enp0s8 managed yes
        ```

        이후 `nmcli device status`에서 STATE가 `disconnected` 또는 `connected`로 바뀌고, `nmcli connection show`에도 나타납니다.

     2. **수동으로 연결 프로파일 생성**

        ```bash
        sudo nmcli connection add \
          type ethernet ifname enp0s8 con-name hostonly \
          ipv4.method manual ipv4.addresses 192.168.56.101/24
        ```

        이렇게 하면 `nmcli connection show`에 "hostonly" 프로파일이 등록되고, `nmcli conn modify hostonly …` 명령도 사용할 수 있습니다.

   * **검증**

     * `nmcli connection show --active` 혹은 `nmcli device show enp0s8` 로 관리 상태와 연결 정보를 확인하세요.
     * `/etc/NetworkManager/NetworkManager.conf`와 `/etc/sysconfig/network-scripts/ifcfg-enp0s8` 파일을 점검하여 `unmanaged` 설정을 제거한 뒤 NM을 재시작(`sudo systemctl restart NetworkManager`)하면 정상적으로 관리됩니다.

5. **호스트-PC와 통신 테스트** – Windows 호스트의 **VirtualBox Host-Only Network 어댑터**는 기본 IP가 192.168.56.1로 설정되어 있습니다. VM에서 호스트(Windows) IP로 ping을 보내 통신이 되는지 확인합니다:

   ```bash
   ping -c 4 192.168.56.1   # 호스트의 host-only IP로 ping
   ```

   192.168.56.1로부터 응답이 오면 성공입니다. 반대로 Windows 명령 프롬프트에서 `ping 192.168.56.101` 명령으로 VM에 ping을 보내도 응답이 와야 합니다. (Windows 방화벽에서 ICMP 차단 시 ping 응답이 없을 수도 있지만 SSH는 가능할 것입니다.)

6. **SSH 서비스 확인** – Rocky Linux는 기본적으로 \*\*sshd(SSH 데몬)\*\*가 설치되어 있습니다. 다음 명령으로 SSH 서비스가 실행 중인지 확인합니다:

   ```bash
   sudo systemctl status sshd
   ```

   `active (running)` 상태이면 SSH 접속 준비가 된 것입니다. (만약 실행 중이 아니면 `sudo systemctl enable --now sshd`로 SSH 서비스를 시작/활성화합니다.)

7. **MobaXterm으로 원격 접속** – 이제 Windows의 MobaXterm을 이용해 SSH 접속을 해보겠습니다. MobaXterm을 실행하고 **Session(세션)** 메뉴에서 **SSH**를 선택합니다.

   * Host(원격 호스트): `192.168.56.101` (VM의 호스트전용 IP)
   * Specify username: `student` (또는 root로 설치했다면 root 입력)
   * 포트: `22` (기본 SSH)
     세션을 저장하고 연결하면 비밀번호를 묻습니다. Linux VM에 설정한 해당 계정의 비밀번호를 입력하면 SSH 접속되어 Rocky Linux 터미널 프롬프트가 나타날 것입니다. 이제부터 Windows 터미널 대신 MobaXterm 창에서 명령어를 입력해 실습을 진행합니다. (만약 \*\*SSH 연결 실패\*\* 시 다음 *문제 해결* 항목을 참고하세요.)

8. **시스템 업데이트 (선택)** – 최초 설치 직후 패키지 업데이트가 필요할 수 있습니다. 인터넷 연결(NAT 통해 가능)을 확인한 후 `dnf` 명령으로 업데이트를 진행합니다:

   ```bash
   sudo dnf update -y
   ```

   (업데이트에는 몇 분 소요될 수 있습니다. 네트워크가 동작하지 않는다면 NAT 설정을 확인하거나 다음 단계에서 IP 설정을 점검하세요.)

**문제 해결:** SSH 연결이 되지 않는 경우 몇 가지 원인을 점검합니다. (1) **IP 주소 확인**: VM의 호스트전용 IP가 정확한지, 호스트에서 해당 IP로 통신 가능한지 확인합니다. (2) **방화벽**: Rocky Linux 방화벽이 SSH 포트를 차단하고 있을 수 있습니다. `sudo firewall-cmd --list-all` 명령을 실행하여 `services: ssh` 또는 `ports: 22`가 포함되어 있는지 확인하고, 없으면 `sudo firewall-cmd --permanent --add-service=ssh && sudo firewall-cmd --reload`로 SSH 허용 후 다시 접속합니다. (3) **SSH 설정**: `sshd` 서비스가 비활성화되어 있거나 **root 로그인**이 금지된 경우입니다. root로 직접 접속이 안 된다면 일반 사용자로 SSH 로그인한 뒤 `sudo -i`로 root 전환하거나, `/etc/ssh/sshd_config`에서 `PermitRootLogin yes`로 설정 후 `systemctl restart sshd`하는 방법도 있습니다. (4) Windows 방화벽이 MobaXterm의 통신을 차단하지 않는지 확인합니다.

## 12:00–13:00: 네트워크 구성 관리 (nmcli 활용 고급 설정)

**이론:** NetworkManager와 nmcli를 활용하여 네트워크 설정을 관리하는 방법을 익힙니다. 여러 개의 네트워크 인터페이스를 다루는 법, 고정 IP와 DHCP 설정 전환, DNS 설정 등을 연습합니다. 또한 **호스트 이름(hostname)** 변경과 `/etc/hosts` 설정을 통해 서버들을 식별하고 통신하는 방법을 소개합니다. 이 단계에서는 향후 여러 VM을 운용하거나 복제할 것을 대비하여 네트워크 구성을 정교하게 다듬습니다.

**실습:** nmcli를 사용하여 세부 네트워크 설정을 적용합니다.

1. **기본 nmcli 명령 익히기** – NetworkManager CLI 도구인 `nmcli`의 주요 명령을 알아봅니다. 예를 들어:

   * 현재 활성 연결 보기: `nmcli device status` (장치별 연결 상태)
   * 연결 프로파일 상세 보기: `nmcli connection show "<프로파일명>"`
   * IP 등 설정 확인: `nmcli connection show "Wired connection 2"`
   * 연결 활성화/비활성: `nmcli connection up <프로파일명>`, `nmcli connection down <프로파일명>`

   이러한 명령으로 현재 네트워크 구성을 이해합니다. 특히 `nmcli connection show "Wired connection 2"`를 실행해 앞서 설정한 고정 IP와 자동연결 여부가 올바르게 적용되어 있는지 확인합니다.

2. **호스트 이름 변경** – VM의 호스트 이름을 의미 있는 이름으로 바꾸겠습니다. 현재 `hostname` 명령으로 확인하면 `server1` (설치 시 지정한 값)일 것입니다. 이를 예를 들어 `hanafn-app1`으로 변경해봅니다:

   ```bash
   sudo hostnamectl set-hostname hanafn-app1
   ```

   변경 후 `hostname`으로 확인하거나 프롬프트에 반영된 것을 볼 수 있습니다. (호스트 이름은 이후 복제 VM마다 고유하게 지정할 예정입니다.)

3. **정적 IP 설정 (DNS 포함)** – 만약 이전 단계에서 DHCP를 사용했다면, 이번에는 고정 IP로 전환해 봅니다. (이미 고정 IP를 설정했다면 DNS 설정만 수정합니다.) 예를 들어 **192.168.56.101/24**를 유지하되 DNS 서버를 수동 지정해보겠습니다. Google DNS(8.8.8.8)를 사용하겠습니다:

   ```bash
   sudo nmcli connection modify "Wired connection 2" ipv4.addresses 192.168.56.101/24 ipv4.gateway 192.168.56.1 ipv4.dns 8.8.8.8 ipv4.method manual
   sudo nmcli connection down "Wired connection 2" && sudo nmcli connection up "Wired connection 2"
   ```

   이 명령으로 게이트웨이(필요시)와 DNS가 추가 설정되었습니다. (Host-Only 네트워크는 외부 라우팅이 필요없어 게이트웨이는 설정하지 않아도 무방합니다.)
   `nmcli connection show "Wired connection 2"`로 DNS 등이 적용되었는지 확인합니다.

4. **/etc/hosts 설정 (옵션)** – 여러 대의 VM이 있을 경우, 각 VM의 `/etc/hosts` 파일에 서로의 IP와 호스트명을 등록해두면 이름으로 접근하기 편리합니다. 현재는 한 대뿐이지만 예시로 hosts 파일을 편집해보겠습니다:

   ```bash
   sudo vi /etc/hosts
   ```

   파일에 다음 행을 추가하고 저장합니다. (vi 편집기 사용이 익숙하지 않으면 nano 편집기를 설치해 사용해도 됩니다.)

   ```
   192.168.56.101   hanafn-app1
   192.168.56.102   hanafn-app2
   192.168.56.100   hanafn-lb
   ```

   이는 추후 만들 VM들의 IP와 호스트명 예시입니다. 일단 현재 VM의 hosts 파일에 자신과 미래 서버들의 이름을 등록해두었습니다. (실제로 다른 VM에서는 각자 파일에 모든 서버를 추가하거나, DNS 서버가 있다면 중앙관리도 고려할 수 있습니다.)

**문제 해결:** nmcli로 IP를 변경한 후 연결이 끊어졌다면, IP 충돌이나 잘못된 설정 가능성이 있습니다. 예를 들어 수동 IP를 설정했는데 이미 DHCP로 해당 IP가 다른 장치에 할당되어 있으면 통신이 불안정할 수 있습니다. 이 경우 다른 IP를 선택하거나 DHCP 서버 설정을 조정하세요. 또한 여러 NIC가 있을 때 **기본 라우트**가 올바른지 확인해야 합니다. NAT 인터페이스(`enp0s3`)를 통해 인터넷을 써야 한다면 `ip route` 명령으로 0.0.0.0/0 경로가 10.0.2.2 (VirtualBox NAT 게이트웨이)로 설정되어 있는지 확인하세요. 만약 고정 IP 설정 시 게이트웨이를 잘못 지정하여 기본 경로가 바뀌었다면 수동으로 수정하거나 해당 인터페이스의 `ipv4.never-default yes` 옵션을 주어 기본게이트웨이를 설정하지 않도록 할 수 있습니다. 호스트 이름 변경 후 SSH 접속 프롬프트가 이전 이름으로 보인다면, SSH 재접속하거나 터미널 제목을 수동 갱신해야 할 수 있으니 혼동하지 않아도 됩니다.

## 13:00–14:00: 방화벽 설정 및 서비스 포트 개방 (firewall-cmd)

**이론:** Rocky Linux 9에서는 **firewalld**를 통해 방화벽을 관리합니다. 기본적으로 공개 영역(public zone)이 사용되며, SSH 등 일부 서비스만 허용되고 나머지 포트는 차단됩니다. 이번 단계에서는 **firewall-cmd** 명령을 사용하여 필요한 서비스와 포트를 방화벽에 열어주는 방법을 배웁니다. 영구(permanent) 설정과 일시(runtime) 설정의 차이를 이해하고, 설정 변경 후 \*\*재로드(reload)\*\*의 중요성을 설명합니다. 또한 방화벽 문제를 진단하는 방법(`--list-all` 등)을 다룹니다.

**실습:** 향후 웹 서버와 DB 서버를 구성할 것을 대비하여, 필요한 포트를 개방합니다.

1. **firewalld 상태 확인** – 우선 방화벽 서비스가 활성화되어 있는지 확인합니다:

   ```bash
   sudo firewall-cmd --state
   ```

   `"running"`이라고 나오면 firewalld가 동작 중입니다. (`systemctl status firewalld`로 좀 더 상세 확인 가능)

2. **현재 방화벽 규칙 확인** – 기본 정책을 살펴봅니다:

   ```bash
   sudo firewall-cmd --list-all
   ```

   출력 예시:

   ```
   public (active)
     target: default
     interfaces: enp0s3 enp0s8
     services: ssh
     ports: 
     ... (생략)
   ```

   public 영역에 SSH가 허용되어 있고 그 외 포트는 비어있음을 확인할 수 있습니다.

3. **SSH 서비스 허용(이미 허용됨)** – SSH(`22/tcp`)는 기본으로 열려 있으나, 만약 `services: ssh`가 없다면 다음으로 추가합니다:

   ```bash
   sudo firewall-cmd --permanent --add-service=ssh
   ```

   (기본적으로 설치 시 SSH는 열려 있으므로 이 단계는 참고용입니다.)

4. **HTTP 서비스 허용** – 나중에 웹 서버(Nginx)가 사용할 **HTTP(80)** 포트를 열어줍니다. HTTP는 firewalld의 predefined 서비스 이름으로 존재합니다.

   ```bash
   sudo firewall-cmd --permanent --add-service=http
   ```

5. **MySQL 서비스/포트 허용** – MySQL 데이터베이스(3306 포트)는 기본 firewalld 서비스 목록에 있을 수 있습니다. 먼저 `services: mysql`이 있는지 확인하고 없으면 추가합니다. (또는 포트 번호로 직접 추가 가능)

   ```bash
   sudo firewall-cmd --permanent --add-service=mysql
   ```

   만약 위 명령에서 서비스 이름을 인식 못 하면 다음처럼 포트 번호로 추가합니다:

   ```bash
   sudo firewall-cmd --permanent --add-port=3306/tcp
   ```

   (MySQL은 서버 자체에서 로컬 연결만 사용한다면 포트를 열 필요 없지만, 여러 VM간 DB 접속이나 호스트-PC에서 접속을 허용하려면 열어줍니다.)

6. **애플리케이션 포트(8080) 허용** – Spring Boot 애플리케이션은 기본적으로 **8080/tcp** 포트를 사용할 예정입니다. 이 포트는 custom 포트이므로 명시적으로 열어야 합니다:

   ```bash
   sudo firewall-cmd --permanent --add-port=8080/tcp
   ```

7. **방화벽 규칙 적용** – 영구 설정을 모두 추가했으면 firewalld를 재로드하여 적용합니다:

   ```bash
   sudo firewall-cmd --reload
   ```

   그런 다음 다시 규칙 확인:

   ```bash
   sudo firewall-cmd --list-all
   ```

   이제 `services: ssh, http, mysql` 및 `ports: 8080/tcp` 등이 포함되어 표시될 것입니다.

8. **방화벽 적용 테스트** – 각 포트가 제대로 열렸는지 간단히 테스트합니다. 예를 들어, 방화벽에 의해 차단되는 경우 연결이 거부되지만 열렸으면 통신이 가능합니다. 나중 단계에서 실제 애플리케이션 접속 테스트로 확인하게 될 것입니다. (예: 웹 서버 구성 후 호스트에서 VM의 80 포트 접속 확인 등)

**문제 해결:** 방화벽 설정 후 서비스 접속이 안 되면, **영역(zone)** 설정을 확인해야 합니다. 기본으로 모든 NIC가 public 영역에 속하지만, 만약 호스트전용 네트워크를 내부망으로 간주하여 **trusted**나 **internal** 영역으로 사용한다면 해당 영역에 규칙을 추가해야 합니다. `firewall-cmd --get-active-zones`로 인터페이스별 영역을 확인하세요. 또한 규칙 변경 후 `--reload`를 빼먹지 않도록 합니다. 실수로 모든 포트를 막아 SSH 접속이 끊어졌다면, **VM 콘솔**로 접속해 `firewall-cmd --panic-off` 등을 이용해 일시적으로 방화벽을 풀고 규칙을 수정할 수 있습니다. 최악의 경우 `sudo systemctl stop firewalld`로 방화벽을 끄고 원인을 파악합니다. (실무 환경이 아니라 학습용이므로 일시적으로 방화벽을 끄고 진행할 수도 있지만, 가능하면 규칙 설정을 익혀 둡니다.)

## 14:00–15:00: MySQL 데이터베이스 설치 및 연동 설정

**이론:** 동적인 웹 애플리케이션을 구축하기 위해 데이터베이스가 필요합니다. MySQL은 대표적인 관계형 DBMS로, Rocky Linux 9에서는 기본 저장소에 MySQL과 호환되는 **MariaDB**가 포함되어 있습니다. 이번 시간에는 MariaDB 서버를 설치하고 데이터베이스를 생성한 뒤, Spring Boot 애플리케이션에서 사용할 계정과 권한을 설정합니다. 또한 데이터베이스 서비스의 시작/정지 관리, 보안 설정(mysql\_secure\_installation)을 간략히 다룹니다.

**실습:** Rocky Linux에 MySQL(MariaDB) 데이터베이스를 설치하고 간단한 설정을 수행합니다.

1. **MariaDB 서버 설치** – Rocky Linux 9 기본 패키지로 제공되는 MariaDB를 사용합니다. `dnf` 패키지 관리자로 MariaDB 서버를 설치합니다:

   ```bash
   sudo dnf install -y mariadb-server
   ```

   설치가 완료되면 MariaDB 서버 데몬(mysqld)을 활성화합니다.

2. **DB 서비스 시작 및 부팅 시 활성화** – systemd를 통해 MariaDB를 시작하고 자동 시작을 설정합니다:

   ```bash
   sudo systemctl enable --now mariadb
   ```

   이 명령으로 즉시 MariaDB가 시작되고, 재부팅 후에도 자동으로 올라오도록 설정됩니다.
   `systemctl status mariadb`로 상태를 확인하여 `active (running)`임을 확인합니다.

3. **초기 보안 설정** – 기본 MariaDB 설정에서는 root 사용자 비밀번호가 빈 상태 등 보안이 취약할 수 있습니다. 이를 보완하기 위해 MySQL에서 제공하는 보안 스크립트를 실행합니다:

   ```bash
   sudo mysql_secure_installation
   ```

   프롬프트에 따라 Root 비밀번호 설정, 익명 사용자 제거, 원격 root 접속 차단, 테스트 데이터베이스 제거, 권한 적용 등을 진행합니다. (학습환경에서는 적절히 선택하되, root 비밀번호는 꼭 설정하세요.)

4. **데이터베이스 및 계정 생성** – 웹 애플리케이션용 데이터베이스와 전용 계정을 만듭니다. MariaDB에 접속하여 SQL 명령을 실행합니다. 우선 MariaDB 클라이언트 실행:

   ```bash
   mysql -u root -p
   ```

   (위에서 설정한 root 비밀번호 입력) 프롬프트가 `MariaDB [(none)]>`으로 바뀌면 다음 SQL을 차례로 입력합니다. (각 줄 끝에 세미콜론 `;` 필수)

   ```sql
   CREATE DATABASE demo;  -- 웹 애플리케이션용 DB 생성
   CREATE USER 'demo_user'@'localhost' IDENTIFIED BY 'DemoPass123!';
   GRANT ALL PRIVILEGES ON demo.* TO 'demo_user'@'localhost';
   FLUSH PRIVILEGES;
   EXIT;
   ```

   설명: `demo`라는 이름의 새 데이터베이스를 만들고, 로컬에서만 접속 가능한 `demo_user` 계정과 암호를 생성했습니다. 이 계정에 `demo` DB에 대한 모든 권한을 부여했습니다. `EXIT`으로 MySQL 쉘을 종료합니다.

5. **동작 확인** – 방금 만든 계정으로 로그인 테스트를 해봅니다:

   ```bash
   mysql -u demo_user -p   # 패스워드 입력
   ```

   접속 후 `SHOW DATABASES;` 명령으로 `demo` DB가 보이면 성공입니다. `EXIT;`으로 나옵니다.

6. **(옵션) 원격 접속 허용 설정** – 만약 웹 애플리케이션이 **다른 VM 또는 호스트**에서 DB에 접속해야 한다면(예: DB 서버를 분리 운용), 해당 호스트에 대한 접속 권한을 부여해야 합니다. 예를 들어 demo\_user가 같은 네트워크 대역에서 접속하려면 MySQL 내에서 `CREATE USER 'demo_user'@'192.168.56.%' IDENTIFIED BY '...';` 등으로 `%` 와일드카드를 사용해 권한을 주어야 합니다. 또한 `bind-address` 설정과 방화벽 포트(3306)도 열어야 합니다. 그러나 여기서는 애플리케이션과 DB를 동일 서버에서 실행할 것이므로 이러한 원격 설정은 필요 없습니다.

**문제 해결:** `mysql_secure_installation` 실행 시 **socket 파일 에러** 등이 발생하면, MariaDB 서비스가 제대로 시작되지 않았을 수 있습니다. `systemctl restart mariadb`로 재시도하고 로그(`/var/log/mariadb.log` 등)를 확인합니다. 만약 root 비밀번호를 분실했다면, 안전 모드로 DB를 띄워 초기화하거나 새 계정을 만들어야 합니다(다소 복잡한 절차로, 필요시 강사가 도와줍니다). `CREATE USER` 단계에서 이미 계정이 존재한다고 나오면, 이전에 한 실습이 남은 것이므로 `DROP USER 'demo_user'@'localhost';` 후 재실행합니다. 또, SQL 문장 끝에 세미콜론 누락 등 문법 오류에 유의합니다.

## 15:00–16:00: Spring Boot 웹 애플리케이션 배포 및 실행

**이론:** 이제 웹 애플리케이션 서버를 구성합니다. 예제로 **Spring Boot** 기반의 자바 웹 애플리케이션을 사용합니다. Spring Boot 애플리케이션은 내장 웹서버(Tomcat)를 통해 8080 포트로 동작하며, 앞서 구성한 MySQL(MariaDB) 데이터베이스와 연동됩니다. 이 단계에서는 Java JDK를 설치하고, Git을 통해 예제 애플리케이션 코드를 가져와 빌드합니다. Linux 환경에서 애플리케이션을 실행하고 프로세스를 관리하는 방법, 로그 확인 방법 등을 익힙니다.

**실습:** Spring Boot 애플리케이션을 서버에 배포하고 실행해봅니다.

1. **Java JDK 설치** – Spring Boot 애플리케이션 실행을 위해 Java가 필요합니다. OpenJDK 17 버전을 설치합니다:

   ```bash
   sudo dnf install -y java-17-openjdk-devel
   ```

   설치 후 `java -version`으로 Java가 정상 설치되었는지 확인하세요. (출력 예: `openjdk version "17.0.x" ...`)

2. **Git 설치 (필요 시)** – 예제 코드를 Git으로 가져올 것이므로 Git 클라이언트가 필요합니다. Rocky Linux Minimal에는 Git이 없을 수 있으니 설치합니다:

   ```bash
   sudo dnf install -y git
   ```

   `git --version`으로 버전을 확인합니다.

3. **애플리케이션 소스 다운로드** – 강사가 제공한 Spring Boot 애플리케이션 소스 코드를 Git 저장소에서 클론합니다. (예시 URL을 사용하되, 실제로는 제공된 레포지토리 URL을 사용해야 합니다.)

   ```bash
   git clone https://github.com/<Github계정>/<예제애플리케이션>.git
   cd <예제애플리케이션>
   ```

   명령 실행 후 애플리케이션 소스 디렉토리로 이동합니다. (`ls` 명령으로 `build.gradle` 또는 `pom.xml` 등이 있는지 확인합니다.)

4. **애플리케이션 빌드** – Gradle Wrapper(`gradlew`) 또는 Maven으로 프로젝트를 빌드합니다. (예제 프로젝트에 Gradle Wrapper가 있다고 가정합니다.) 우선 gradlew에 실행 권한을 주고 빌드를 수행합니다:

   ```bash
   chmod +x gradlew
   ./gradlew build
   ```

   **네트워크 연결 주의:** 처음 Gradle 빌드를 하면 필요한 라이브러리를 다운로드하기 때문에 시간이 조금 걸릴 수 있습니다. 빌드가 성공하면 `BUILD SUCCESSFUL` 메시지가 나타나고, `build/libs` 디렉토리에 실행 가능한 JAR 파일이 생성됩니다.
   (만약 Maven 사용 프로젝트라면 `mvn package` 명령을 사용하고, 산출물은 `target/` 디렉토리에 생깁니다. 이 과정도 유사합니다.)

5. **DB 연결 설정 확인** – 애플리케이션이 DB에 연결하려면 설정 파일(`application.properties` 등)에 DB접속 정보가 맞게 되어있어야 합니다. 일반적으로 Spring Boot 애플리케이션의 리소스 경로(`src/main/resources/`)에 `application.properties` 또는 `application.yml` 파일이 있으며, 그 안에 데이터소스 URL, 계정, 비밀번호 설정이 있습니다. 이를 열어 잘 설정되었는지 확인합니다:

   ```bash
   vi src/main/resources/application.properties
   ```

   (또는 빌드된 JAR 내부 설정을 참고할 수도 있습니다.) 예를 들어 다음과 같이 설정되어 있어야 합니다.

   ```
   spring.datasource.url=jdbc:mysql://localhost:3306/demo
   spring.datasource.username=demo_user
   spring.datasource.password=DemoPass123!
   ```

   만약 호스트 주소나 계정 정보가 다르게 되어 있다면, 우리 환경에 맞게 수정한 뒤 다시 빌드합니다. (사전에 강사가 환경에 맞게 설정해두었다면 이 과정은 넘어갑니다.)

6. **애플리케이션 실행** – 빌드된 JAR 파일을 실행합니다. 경로는 Gradle 빌드 기준 `build/libs/<애플리케이션이름>-0.0.1-SNAPSHOT.jar`와 같습니다 (버전 번호는 프로젝트마다 다를 수 있음). 예를 들어:

   ```bash
   java -jar build/libs/hello-springboot-0.0.1-SNAPSHOT.jar
   ```

   명령을 실행하면 콘솔에 Spring Boot 애플리케이션 로그가 출력됩니다. 처음 실행 시 DB에 연결하여 테이블을 생성하거나 초기화하는 로그가 나올 수 있습니다. **"log started"** 또는 **"Tomcat started on port(s): 8080"** 등의 메시지가 보이면 성공적으로 구동된 것입니다.

7. **로컬에서 애플리케이션 확인** – 같은 VM 내에서 애플리케이션에 요청을 보내 확인합니다. 예를 들어 애플리케이션이 `/welcome` 엔드포인트를 제공한다면:

   ```bash
   curl http://localhost:8080/welcome
   ```

   또는 기본 페이지가 있다면 `curl http://localhost:8080`를 실행합니다. 해당 엔드포인트의 HTML이나 JSON 응답 등이 콘솔에 출력되면 애플리케이션이 정상 작동 중입니다. (응답 예시: `"Hello World"` 메시지 또는 간단한 웹 페이지 내용)

8. **백그라운드 실행 (옵션)** – 현재 터미널에서 애플리케이션이 실행 중이므로, 터미널을 차단하고 있습니다. 다른 작업을 위해 **애플리케이션을 백그라운드로 실행**하거나 **새 터미널 세션**이 필요합니다. 간단히 프로세스를 백그라운드로 보내려면 `Ctrl + C`로 일단 종료한 후, 아래와 같이 실행합니다:

   ```bash
   nohup java -jar build/libs/hello-springboot-0.0.1-SNAPSHOT.jar > app.log 2>&1 &
   ```

   이렇게 하면 애플리케이션이 백그라운드에서 실행되며 로그는 `app.log` 파일에 기록됩니다. `jobs` 명령으로 백그라운드 작업을 확인하거나, `ps -ef | grep java`로 프로세스가 떠있는지 확인합니다. (고급: 이후 `kill <PID>`로 종료 가능합니다.)
   **※ 중요:** 실습 시에는 간단히 한 개의 터미널에서 실행해 보고, 필요하면 새 세션(MobaXterm 탭)을 열어 다음 단계를 진행합니다.

**문제 해결:** 애플리케이션 구동 중 **오류 발생** 시 로그를 면밀히 살펴봅니다. 예를 들어 **DB 연결 오류**(Communications link failure 등)가 나오면, DB 서비스가 비활성화되었거나 `application.properties`의 DB 설정이 잘못된 것입니다. 이때는 MariaDB 서비스 상태를 `sudo systemctl status mariadb`로 확인하거나, 설정 정보를 재확인합니다. **포트 충돌 오류**(Address already in use)가 발생하면 이미 해당 포트에 프로세스가 있는 것이므로 `lsof -i:8080` 등으로 확인 후 기존 프로세스를 종료합니다. Gradle 빌드 실패 시 인터넷 연결 문제이거나 테스트 케이스 실패 등이 원인일 수 있으므로, 네트워크를 체크하고 필요하다면 빌드 명령에 `-x test` 옵션을 주어 테스트를 건너뜁니다. 만약 애플리케이션이 실행은 되는데 `/welcome` 등에 접속해도 응답이 없다면, 방화벽 설정(8080포트 개방 여부)과 SELinux 설정을 점검해야 합니다. (SELinux가 활성화된 상태에서 8080포트 사용을 차단할 수 있습니다. 다음 단계에서 SELinux 관련 조치를 다룹니다.)

## 16:00–17:00: Nginx 설치 및 로드 밸런서 구성

**이론:** 마지막으로 **Nginx** 웹 서버를 사용하여 로드 밸런서를 구성합니다. 로드 밸런서는 다수의 애플리케이션 인스턴스(Spring Boot 서버들)에 트래픽을 분산시켜줄 수 있습니다. 또한 Nginx를 프록시로 두어 클라이언트는 80번 포트로 접속하고, Nginx가 백엔드로 들어온 요청을 8080포트의 Spring Boot 서버들에게 전달하도록 설정합니다. 이를 통해 하나의 엔드포인트로 여러 서버를 효과적으로 사용할 수 있습니다. (실습 환경에서는 한 대의 VM을 복제하여 다수의 서버를 시뮬레이션합니다.)

**실습:** 두 개의 애플리케이션 서버 인스턴스와 하나의 Nginx 로드 밸런서 서버를 구성합니다. VM 복제 및 Nginx 설정 과정을 따르세요.

1. **VM 복제하여 다중 서버 구성** – 현재까지 설정을 마친 Rocky Linux VM(`hanafn-app1`)을 복제하여 동일한 서버를 두 개 더 만듭니다. 이는 VirtualBox의 **Clone(복제)** 기능으로 수행합니다.

   * 먼저 현재 VM을 \*\*종료(power off)\*\*합니다 (복제를 위해 종료 필요). MobaXterm 연결은 끊고 VirtualBox에서 해당 VM을 종료하십시오.
   * VirtualBox 관리자에서 `hanafn-app1` VM을 오른쪽 클릭하고 \*\*Clone...\*\*을 선택합니다. 새 VM 이름을 `hanafn-app2`로 지정합니다. **Full Clone(전체 복제)** 및 **새 MAC 주소 생성** 옵션을 선택하여 복제를 완료합니다.
   * 동일한 방법으로 `hanafn-app1`을 한 번 더 복제하여 `hanafn-lb`라는 세 번째 VM을 만듭니다.

   이제 VirtualBox에 세 개의 VM(`hanafn-app1`, `hanafn-app2`, `hanafn-lb`)이 있어야 합니다. 각각 NAT 및 Host-Only 어댑터 설정은 원본과 동일하게 복제되었으므로 준비되어 있습니다.

2. **복제 VM 네트워크/호스트명 조정** – 복제된 VM들을 부팅하고 IP/호스트명을 고유하게 변경합니다.

   * **hanafn-app2 설정:** `hanafn-app2` VM을 시작합니다. 부팅 후 콘솔에서 로그인 (root 또는 student)합니다. 현재 `enp0s8`의 IP가 원본과 같은 192.168.56.101로 되어 있어 충돌 가능성이 있으므로 즉시 변경합니다.

     ```bash
     sudo nmcli connection modify "Wired connection 2" ipv4.addresses 192.168.56.102/24 ipv4.method manual
     sudo nmcli connection down "Wired connection 2" && sudo nmcli connection up "Wired connection 2"
     ```

     그리고 호스트명을 변경합니다:

     ```bash
     sudo hostnamectl set-hostname hanafn-app2
     ```

     변경 후 `hostname`으로 확인하거나 프롬프트에 반영된 것을 볼 수 있습니다. (호스트 이름은 이후 복제 VM마다 고유하게 지정할 예정입니다.)
   * **hanafn-lb 설정:** `hanafn-lb` VM을 시작하고 로그인합니다. 마찬가지로 IP를 이번에는 192.168.56.100으로 설정하겠습니다 (LB 서버는 .100 사용):

     ```bash
     sudo nmcli connection modify "Wired connection 2" ipv4.addresses 192.168.56.100/24 ipv4.method manual
     sudo nmcli connection down "Wired connection 2" && sudo nmcli connection up "Wired connection 2"
     sudo hostnamectl set-hostname hanafn-lb
     ```

     적용 확인 (`ip addr`에서 .100 확인).

     이제 Host-Only 네트워크 상에서 세 VM의 IP가 각기 .100(LB), .101(App1), .102(App2)로 고유해졌습니다. 혹시 변경 전 원본 VM이 실행 중이었다면 IP 충돌이 났겠지만, 우리가 원본을 종료한 상태에서 복제했으므로 안전합니다. 마지막으로 원본 VM(`hanafn-app1`)도 다시 시작합니다. 세 VM 모두 가동하여 MobaXterm 등으로 각 VM에 접속할 수 있습니다. (hosts 파일에 미리 등록해두었으므로 각 호스트명으로도 ping/SSH 시도 가능하며, 안 될 경우 hosts 파일을 각 VM과 Windows에도 최신 IP에 맞게 수정하세요.)

3. **애플리케이션 서버 기동** – 이제 두 개의 애플리케이션 서버(`hanafn-app1`, `hanafn-app2`)를 실행합니다. 각 VM에 SSH 접속하거나 콘솔을 열어, 앞서 빌드한 Spring Boot 애플리케이션 JAR을 실행합니다. (복제되었으므로 `/home/student/<예제애플리케이션>` 경로 등 소스와 JAR가 동일하게 존재합니다.)

   * `hanafn-app1`에서:

     ```bash
     cd ~/<예제애플리케이션>
     nohup java -jar build/libs/hello-springboot-0.0.1-SNAPSHOT.jar > app.log 2>&1 &
     ```
   * `hanafn-app2`에서도 동일하게 해당 경로에서 애플리케이션을 백그라운드로 실행합니다.
     각 서버에서 `ss -tnlp | grep 8080` 명령으로 Java 프로세스가 8080포트 LISTEN 중인지 확인합니다. 또한 `curl http://localhost:8080`으로 개별 테스트하여 응답이 오는지 확인하세요. 두 서버 모두 애플리케이션이 정상 동작 중이면 준비 완료입니다.
     *(주의:* 만약 애플리케이션이 DB를 localhost로 보도록 설정되어 있고, 각 VM에 자체 MariaDB가 설치되어 있으므로 각각 정상 작동할 것입니다. 혹시 애플리케이션 설정이 특정 IP의 DB로 향하도록 돼 있다면(hanafn-app1의 DB 등), `hanafn-app2`에서는 DB 접속에 실패할 수 있습니다. 이 경우 `hanafn-app2`의 `application.properties`를 수정하여 DB 호스트를 `localhost`로 바꾸고 재빌드/재실행해야 합니다. 본 실습에서는 각 앱 서버가 자체 DB를 사용한다고 가정합니다.)\*

4. **Nginx 설치 (로드 밸런서)** – 로드밸런서를 맡을 `hanafn-lb` 서버에 Nginx를 설치합니다:

   ```bash
   sudo dnf install -y nginx
   ```

   설치 후 바로 서비스를 시작하지는 마십시오 (설정 변경 후 시작 예정).

5. **Nginx 설정** – Nginx를 역방향 프록시(reverse proxy) 겸 로드 밸런서로 설정하기 위해 설정 파일을 수정합니다. `hanafn-lb` 서버에서 Nginx 기본 설정 파일(`/etc/nginx/nginx.conf`)이나 별도의 구성 파일(`/etc/nginx/conf.d/`)을 편집합니다. 여기서는 간단히 기본 설정파일의 `http { }` 블록에 내용을 추가해보겠습니다:

   ```bash
   sudo vi /etc/nginx/nginx.conf
   ```

   http 블록 내 적절한 위치에 다음 내용을 추가하거나, 기존 server 블록을 교체합니다:

   ```
       upstream bootapp {
           server 192.168.56.101:8080;
           server 192.168.56.102:8080;
       }

       server {
           listen       80;
           server_name  localhost;

           location / {
               proxy_pass http://bootapp;
           }
       }
   ```

   설명: `upstream bootapp` 섹션에 두 대의 애플리케이션 서버 주소와 포트를 나열했습니다. 이렇게 하면 `bootapp`이라는 업스트림 그룹으로 라운드로빈 로드밸런싱이 구성됩니다. 아래 server 블록에서는 80 포트로 들어온 요청을 모두 `proxy_pass` 지시어를 통해 `bootapp` 업스트림(즉 2대의 8080 서버)으로 전달합니다. `server_name`는 특별히 사용하지 않으므로 localhost로 두었습니다.

   설정을 저장한 뒤, **문법 오류 검사**를 합니다:

   ```bash
   sudo nginx -t
   ```

   `syntax is ok`와 `test is successful` 메시지가 나오면 설정에 문제없는 것입니다.

6. **SELinux 보안 컨텍스트 조정** – Rocky Linux의 SELinux는 기본적으로 웹서버(Nginx)가 외부로 프록시 연결을 만드는 것을 차단합니다. Nginx가 192.168.56.101:8080 등의 외부(다른 호스트) 자원에 연결하려 하면 SELinux 보안 정책에 막힐 수 있습니다. 이를 허용하려면 SELinux Boolean 값을 설정해야 합니다. `hanafn-lb` 서버에서 다음을 실행합니다:

   ```bash
   sudo setsebool -P httpd_can_network_connect on
   ```

   이 설정은 SELinux에게 Nginx(Apache 포함 웹서비스)가 네트워크로 아웃바운드 접속을 할 수 있게 허용하는 스위치입니다. (`-P` 옵션으로 영구 적용)

7. **방화벽 설정 확인 (LB)** – 로드밸런서 서버의 방화벽에서 80포트(HTTP)가 열려 있어야 합니다. 이전에 원본 VM에서 HTTP 서비스를 추가했으므로, 복제된 `hanafn-lb`에서도 동일하게 설정되어 있을 것입니다. 확인 차:

   ```bash
   sudo firewall-cmd --list-all | grep http
   ```

   만약 비어있다면 `sudo firewall-cmd --permanent --add-service=http && sudo firewall-cmd --reload`로 추가합니다.

8. **Nginx 서비스 시작** – 설정이 완료되었으면 Nginx를 시작하고 부팅 시 활성화합니다:

   ```bash
   sudo systemctl start nginx
   sudo systemctl enable nginx
   ```

   `systemctl status nginx`로 active 상태 확인. 오류로 inactive 상태라면 `journalctl -xe`에서 원인을 확인합니다 (일반적으로 설정 오타, SELinux 등).

9. **로드밸런서 동작 테스트** – 호스트(Windows) PC에서 웹 브라우저를 열고 로드밸런서의 IP인 `http://192.168.56.100`으로 접속합니다. 또는 MobaXterm 탭에서 `curl 192.168.56.100` 명령을 실행해봐도 됩니다. 이 요청이 Nginx를 통해 백엔드의 Spring Boot 애플리케이션으로 전달되어 응답이 오는지 확인합니다. 브라우저에서 애플리케이션 페이지가 나타나면 성공입니다.
   로드밸런싱이 제대로 되는지 확인하려면 브라우저에서 여러 번 새로고침하거나 또는 `curl`로 연속 요청을 보내보고, 각 앱 서버에서 로그를 확인합니다. 두 서버의 로그에 번갈아 요청 기록이 남았다면 라운드로빈으로 분산된 것입니다. (애플리케이션 응답에 서버 호스트명이 표시되도록 개발되었다면 쉽게 구분 가능하지만, 그렇지 않다면 로그로 확인합니다.)
   한쪽 애플리케이션 서버를 종료하고 요청을 보내어, 나머지 서버로 계속 서비스 되는지도 실험해 볼 수 있습니다. 이때 Nginx 설정상 기본값으로 일정 시간 연결 실패한 서버를 제외하고 동작합니다.

**문제 해결:** 로드밸런서 설정 후 **192.168.56.100 접속 불가** 상황에서는 다음을 점검합니다. (1) `hanafn-lb`의 Nginx 서비스 상태 및 포트 리스닝 확인: `ss -tnlp | grep :80`으로 nginx가 80포트 LISTEN 중인지 봅니다. (2) `hanafn-lb`에서 `curl 192.168.56.101:8080` 등으로 백엔드 서버들과 통신이 되는지 확인합니다. 통신이 안 되면 네트워크 또는 방화벽 이슈입니다 (백엔드 서버 `hanafn-app`들의 방화벽 8080이 열려있는지, host-only 네트워크로 서로 통신 가능한지 확인). (3) SELinux 설정이 적용되지 않아 Nginx 에러 로그(`/var/log/nginx/error.log`)에 "permission denied while connecting to upstream"이 있다면, `