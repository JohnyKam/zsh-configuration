# zsh configuration

Just some .zshrc config backup shared between all machines.

Required: [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)

# Install [PowerLevel10K](https://github.com/romkatv/powerlevel10k) Theme for Oh My Zsh

Run this to install PowerLevel10K:
<pre><code>git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k></code></pre>

Now that it's installed, open the "~/.zshrc" file with your preferred editor and change the value of "ZSH_THEME" as shown below:

<pre><code>ZSH_THEME="powerlevel10k/powerlevel10k"</code></pre>

To reflect this change on your terminal, restart it or run this command:

<pre><code>source ~/.zshrc</code></pre>

### Meslo Nerd Font
<pre><code>https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Meslo</code></pre>

### Update VSCode Terminal Font (Optional)
Open settings.json and add this line:

<pre><code>"terminal.integrated.fontFamily": "MesloLGS NF"</pre></code>

### Configure PowerLevel10K

Restart terminal. You should now be seeing the PowerLevel10K configuration process. If you don't, run the following:
<pre><code>p10k configure</pre></code>