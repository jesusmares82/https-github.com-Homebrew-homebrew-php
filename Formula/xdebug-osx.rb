require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class XdebugOsx < Formula
  desc "Simple bash script to toggle xdebug on/off in OSX"
  homepage "https://github.com/w00fz/xdebug-osx"
  url "https://github.com/w00fz/xdebug-osx/archive/1.1.tar.gz"
  sha256 "fa2eabad41d7da5bde8eaefc3b260096c0b53dcdb4f0c7c7e5e132872a1eb541"
  head "https://github.com/w00fz/xdebug-osx.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7f786f7d997e38d5a4bf17873838ff458f7d5a1cd6cd8a5b3a7388e727f0f5a2" => :el_capitan
    sha256 "2a74adb2ebab0732e00c0835c9f853350ed0c765c9f202b4fa157b32d8f649c2" => :yosemite
    sha256 "96425aa2f1762aedf10e9d8c0871fee89f9f66c604ab67c5dbdda7352bc0df60" => :mavericks
  end

  depends_on PhpMetaRequirement
  depends_on "php53-xdebug" if Formula["php53"].linked_keg.exist?
  depends_on "php54-xdebug" if Formula["php54"].linked_keg.exist?
  depends_on "php55-xdebug" if Formula["php55"].linked_keg.exist?
  depends_on "php56-xdebug" if Formula["php56"].linked_keg.exist?
  depends_on "php70-xdebug" if Formula["php70"].linked_keg.exist?
  depends_on "php71-xdebug" if Formula["php71"].linked_keg.exist?

  def install
    bin.install "xdebug-toggle"
  end

  def caveats; <<-EOS.undent
    Usage:
      xdebug-toggle       # outputs the current status
      xdebug-toggle on    # enables xdebug
      xdebug-toggle off   # disables xdebug
    EOS
  end

  test do
    system "#{bin}/xdebug-toggle"
  end
end
