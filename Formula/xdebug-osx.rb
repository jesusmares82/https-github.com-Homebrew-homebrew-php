require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class XdebugOsx < Formula
  desc "Simple bash script to toggle xdebug on/off in OSX"
  homepage "https://github.com/w00fz/xdebug-osx"
  url "https://github.com/w00fz/xdebug-osx/archive/1.0.tar.gz"
  sha256 "42b4f06422838083efa9bfe1d545f369802ba62c224c4cb54694e40dc1966725"
  head "https://github.com/w00fz/xdebug-osx.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f181d7e8929e67de9513e9b17b5d12f34d9bdb6b9dc39807d093bf6be8938258" => :el_capitan
    sha256 "128b1d67483fda8ff3e7eb78822dd0fffbabc9af5994d67cbfbdef16386d48e4" => :yosemite
    sha256 "8a281099f3017433657a42f5d52ace8bcebf73f78ccbee2cb1e353670c3c0b75" => :mavericks
  end

  depends_on PhpMetaRequirement
  depends_on "php53-xdebug" if Formula["php53"].linked_keg.exist?
  depends_on "php54-xdebug" if Formula["php54"].linked_keg.exist?
  depends_on "php55-xdebug" if Formula["php55"].linked_keg.exist?
  depends_on "php56-xdebug" if Formula["php56"].linked_keg.exist?
  depends_on "php70-xdebug" if Formula["php70"].linked_keg.exist?
  depends_on "php71-xdebug" if Formula["php71"].linked_keg.exist?

  def install
    bin.install "xdebug"
  end

  def caveats; <<-EOS.undent
    Usage:
      xdebug       # outputs the current status
      xdebug on    # enables xdebug
      xdebug off   # disables xdebug
    EOS
  end

  test do
    system "#{bin}/xdebug"
  end
end
