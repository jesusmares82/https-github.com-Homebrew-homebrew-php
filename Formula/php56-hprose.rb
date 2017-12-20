require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Hprose < AbstractPhp56Extension
  init
  desc "High Performance Remote Object Service Engine"
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.6.tgz"
  head "https://github.com/hprose/hprose-pecl.git"
  sha256 "29292d9ba15c3f838622bbf8f608a0fb4fb6bba6019f6e6bffe1eedb572881b8"

  bottle do
    cellar :any_skip_relocation
    sha256 "18b0070420a14dedcef1898b7667685b14f4e618e45f5dcae15cb8e5f62abda9" => :el_capitan
    sha256 "a124951003ce52040e7d1c112413796f0e3e9cd482a9826f63e0aa7e85f3cbea" => :yosemite
    sha256 "569df5f46c1c068f4c0a950732eb7a0aca3500d724e5c2a5eddffdf351cbd973" => :mavericks
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end
end
