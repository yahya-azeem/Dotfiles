# ----------------------------------------------------- 
# Nix Shell Environment for Technical Execution (Refined)
# ----------------------------------------------------- 

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "technical-execution-env";

  buildInputs = with pkgs; [
    # --- Coding & Development ---
    python3
    python3Packages.pip
    nodejs_20
    go
    rustc
    cargo
    git
    gh
    gcc
    gnumake
    cmake
    
    # --- Modern CLI Tools ---
    lazygit
    lazydocker
    go-task
    tldr
    ripgrep
    fd
    fzf
    jq
    yq
    tmux
    neovim
    
    # --- Security & Pentesting (Kali Style) ---
    nmap
    metasploit
    sqlmap
    ffuf
    gobuster
    nikto
    thc-hydra
    aircrack-ng
    hashcat
    john
    wireshark-cli
    tshark
    burpsuite
    exploitdb
    commix
    recon-ng
    dirb
    wordlists
    
    # --- Reverse Engineering ---
    ghidra-bin
    radare2
    cutter
    binwalk
    gdb
    pwndbg
    strace
    ltrace
    upx
    hexdump
    
    # --- Network & Debugging ---
    curl
    wget
    dig
    ncat
    tcpdump
    strace
    lsof
    mtr
    socat
    
    # --- System Monitoring ---
    btop
    htop
    iotop
    iftop
  ];

  shellHook = ''
    export HISTCONTROL=ignoreboth
    echo "-----------------------------------------------------"
    echo " 🌑 MONOCHROME TECHNICAL EXECUTION ENVIRONMENT 🌑 "
    echo "-----------------------------------------------------"
    echo " Type 'tldr <tool>' for quick usage examples. "
    echo "-----------------------------------------------------"
  '';
}
