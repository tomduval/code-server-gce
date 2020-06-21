curl -fsSL https://code-server.dev/install.sh | sh
systemctl --user enable --now code-server
# sed -i.bak 's/password: .*/password: gHtdRANcTRem/' ~/.config/code-server/config.yaml
sed -i.bak 's/bind-addr: 127.0.0.1:8080/bind-addr: 0.0.0.0:8080/' ~/.config/code-server/config.yaml
systemctl --user restart code-server

sudo apt update

sudo apt-get install -y python3-pip
sudo apt-get install -y virtualenv
virtualenv ~/venv --python=python3
echo 'source ~/venv/bin/activate' >> ~/.bashrc

sudo apt install -y npm
sudo npm install -g yarn

echo '"\e[A": history-search-backward # arrow up' >> ~/.inputrc
echo '"\e[B": history-search-forward # arrow down' >> ~/.inputrc

sudo apt-get install -y git

sudo apt-get install -y tmux
mkdir bin
mv code-shell bin/code-shell
sudo chmod +x bin/code-shell

sudo apt-get install -y bsdtar curl
mkdir -p ~/.local/share/code-server/extensions
curl -JL https://github.com/Microsoft/vscode-python/releases/download/2020.5.86806/ms-python-release.vsix | bsdtar -xvf - extension
mv extension ~/.local/share/code-server/extensions/ms-python.python-vscode-2020.5.86806

code-server --install-extension esbenp.prettier-vscode
code-server --install-extension mhutchie.git-graph
code-server --install-extension eamodio.gitlens

~/venv/bin/pip install -r requirements.txt

mkdir .local/share/code-server/User
mv settings.json .local/share/code-server/User/settings.json
sudo chown -R coder:coder ~/.local

git config --global --add user.email tomdvdb@gmail.com
git config --global --add user.name "Tom du Val"

mkdir -p ~/repos
