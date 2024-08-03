#!/bin/bash

# Répertoire de téléchargement des polices
download_dir="$HOME/.termux/fonts"

# Crée le répertoire s'il n'existe pas
mkdir -p "$download_dir"

# Tableau des URLs des polices Nerd Fonts à télécharger
font_urls=(
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/3270/Regular/3270NerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Agave/AgaveNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/AnonymousPro/Regular/AnonymiceProNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Arimo/Regular/ArimoNerdFont-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/AurulentSansMono/AurulentSansMNerdFontMono-Regular.otf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/BigBlueTerminal/BigBlueTerm437NerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/BitstreamVeraSansMono/Regular/BitstromWeraNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CascadiaCode/Regular/CaskaydiaCoveNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/IBMPlexMono/Mono/BlexMonoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CodeNewRoman/Regular/CodeNewRomanNerdFontMono-Regular.otf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/ComicShannsMono/ComicShannsMonoNerdFontMono-Regular.otf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Cousine/Regular/CousineNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DaddyTimeMono/DaddyTimeMonoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/DejaVuSansMNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/DroidSansMNerdFontMono-Regular.otf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FantasqueSansMono/Regular/FantasqueSansMNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraMono/Regular/FiraMonoNerdFontMono-Regular.otf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Gohu/uni-14/GohuFontuni14NerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Go-Mono/Regular/GoMonoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hasklig/Regular/HasklugNerdFontMono-Regular.otf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hermit/Regular/HurmitNerdFontMono-Regular.otf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/iA-Writer/Mono/Regular/iMWritingMonoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Inconsolata/InconsolataNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/InconsolataGo/Regular/InconsolataGoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/InconsolataLGC/Regular/InconsolataLGCNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/IosevkaNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/IosevkaTerm/Regular/IosevkaTermNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/JetBrainsMonoNLNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Lekton/Regular/LektonNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/LiberationMono/LiterationMonoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Lilex/Regular/LilexNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/M/Regular/MesloLGMNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Monofur/Regular/MonofurNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Monoid/Regular/MonoidNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Mononoki/Regular/MononokiNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/MPlus/M_Plus_1_code/M%2B1CodeNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Noto/Mono/NotoMonoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/OpenDyslexic/Mono-Regular/OpenDyslexicMNerdFontMono-Regular.otf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Overpass/Mono/Regular/OverpassMNerdFontMono-Regular.otf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/ProFont/profontiix/ProFontIIxNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/ProggyClean/SlashedZero/ProggyCleanSZNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/RobotoMonoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/ShareTechMono/ShureTechMonoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/SauceCodeProNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SpaceMono/Regular/SpaceMonoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Terminus/Regular/TerminessNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Tinos/Regular/TinosNerdFont-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Ubuntu/Regular/UbuntuNerdFont-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/UbuntuMono/Regular/UbuntuMonoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/VictorMono/Regular/VictorMonoNerdFontMono-Regular.ttf"
)

# Télécharge chaque police
for url in "${font_urls[@]}"; do
  echo "Téléchargement de $url..."
  curl -L -o "$download_dir/${url##*/}" "$url"
done

echo "Toutes les polices ont été téléchargées dans $download_dir."
