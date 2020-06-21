FROM codercom/code-server:latest

RUN sudo apt update

RUN sudo apt-get install -y python3-pip
RUN sudo apt-get install -y virtualenv
RUN virtualenv ~/venv --python=python3
RUN echo 'source ~/venv/bin/activate' >> ~/.bashrc

RUN sudo apt install -y npm
RUN sudo npm install -g yarn

RUN echo '"\e[A": history-search-backward # arrow up' >> ~/.inputrc
RUN echo '"\e[B": history-search-forward # arrow down' >> ~/.inputrc

RUN sudo apt-get install -y git

RUN sudo apt-get install -y tmux
COPY './code-shell' 'bin/code-shell'
RUN sudo chmod +x bin/code-shell

RUN sudo apt-get install -y bsdtar curl
RUN mkdir -p ~/.local/share/code-server/extensions
RUN curl -JL https://github.com/Microsoft/vscode-python/releases/download/2020.5.86806/ms-python-release.vsix | bsdtar -xvf - extension
RUN mv extension ~/.local/share/code-server/extensions/ms-python.python-vscode-2020.5.86806

RUN code-server --install-extension mhutchie.git-graph
RUN code-server --install-extension eamodio.gitlens
RUN code-server --install-extension esbenp.prettier-vscode

COPY 'requirements.txt' 'requirements.txt'
RUN ~/venv/bin/pip install -r requirements.txt

COPY '.tmux.conf' '.tmux.conf'

COPY 'settings.json' '.local/share/code-server/User/settings.json'
RUN sudo chown -R coder:coder ~/.local

# ENV PASSWORD="gHtdRANcTRem"
RUN git config --global --add user.email tomdvdb@gmail.com
RUN git config --global --add user.name "Tom du Val"

RUN mkdir -p ~/repos

EXPOSE 8080
EXPOSE 3000
