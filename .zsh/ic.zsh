ic() {
  if [[ $1 == (help|-h|--help) ]]; then
    cat <<'EOF'
ic - .incus.env を親ディレクトリへ遡って探し、Incus インスタンス内の
     対応するディレクトリでコマンドを実行する

使い方:
  ic                 ログインシェルを起動
  ic <cmd> [args]    コマンドを実行
  ic start | stop    インスタンスの起動 / 停止
  ic help            このヘルプ

.incus.env (シェル変数):
  INSTANCE_NAME  インスタンス名 (必須)
  LOGIN_USER     作業ユーザー名 (省略時 root)
  MOUNT_DIST     .incus.env のあるディレクトリに対応するインスタンス内パス
                 (省略時 /home/$LOGIN_USER)

作業ディレクトリ:
  .incus.env からの相対パスを MOUNT_DIST に付けた場所
  例) ~/proj/src/app で実行、MOUNT_DIST=/work → /work/src/app
EOF
    return
  fi

  local root=$PWD
  while [[ ! -f $root/.incus.env && $root != / ]]; do root=${root:h}; done
  [[ -f $root/.incus.env ]] || { print -u2 "ic: .incus.env not found"; return 1; }

  local INSTANCE_NAME LOGIN_USER MOUNT_DIST
  source "$root/.incus.env"
  [[ -n $INSTANCE_NAME ]] || { print -u2 "ic: INSTANCE_NAME is not set"; return 1; }

  case $1 in
    start|stop) incus $1 $INSTANCE_NAME; return ;;
  esac

  local u=${LOGIN_USER:-root}
  local home=/home/$u; [[ $u == root ]] && home=/root
  local wd=${MOUNT_DIST:-$home}
  wd=${wd%/}${PWD#$root}

  local cmd='exec $SHELL -l'
  (( $# )) && cmd=${(j: :)${(q)@}}

  incus exec $INSTANCE_NAME -- su -l $u -c "cd ${(q)wd:-/} && $cmd"
}
