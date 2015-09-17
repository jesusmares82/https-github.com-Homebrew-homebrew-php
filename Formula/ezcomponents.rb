require 'formula'

class Ezcomponents < Formula
  url 'http://ezcomponents.org/files/downloads/ezcomponents-2009.2.1-lite.tar.bz2'
  homepage 'http://ezcomponents.org'
  sha256 'c7a4933dc8b100711c99cc2cc842da6448da35a4a95e8874342a92c79b8f8721'

  bottle do
    cellar :any_skip_relocation
    sha256 "ca3dd6dd4ee7127084f3b1620d520ab2855b189d4ef55b4852d2657e4fc33a7a" => :el_capitan
    sha256 "9a14d90c3ea2818cf40a56c59c3f1c37424043efd229affabcf3388a53482893" => :yosemite
    sha256 "86638bdd050ee39d950336b900c4931ca4cc7269bf33bd3cfca77176c8c2a645" => :mavericks
  end

  def install
    (lib+'ezc').install Dir['*']
  end

  def caveats; <<-EOS.undent
    The eZ Components are installed in #{HOMEBREW_PREFIX}/lib/ezc
    Remember to update your php include_path if needed
    EOS
  end

end
