require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Propro < AbstractPhp72Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-2.0.1.tar.gz"
  sha256 "0f310cf0ea11950ff48073537b87b99826ad653c8405556fa42475504c263b64"
  head "https://github.com/m6w6/ext-propro.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ce462c31026376770dcf15a35a10695db5e811ed82dab6bffc22ea099b2d1b3e" => :sierra
    sha256 "5538712235900a0293f353bbce6da9e3a814a5bb61da2c32c8cc1c834c1853c0" => :el_capitan
    sha256 "514d5f10066f1b753f1a016ca9911074c35a7b56ffcb8f908f6e6f86204da698" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h src/php_propro_api.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
