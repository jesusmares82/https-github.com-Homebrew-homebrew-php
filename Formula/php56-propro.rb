require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Propro < AbstractPhp56Extension
  init
  desc "A reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://pecl.php.net/get/propro-1.0.0.tgz"
  sha256 "9825d50ab4bb214428cd11c14c2f389c16aded09db16d266f27f147a7f2371f2"

  head "https://git.php.net/repository/pecl/php/propro.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "91abdbe6f3559f9b26e86814c030ff1b3eecfd145a49df7ebc6c435436120508" => :el_capitan
    sha256 "ab993a2ecc4af36324e48b001b121a779e006333498913d6ce222fbc4dcbe93e" => :yosemite
    sha256 "d00dd2523df2e006cd89c1b9f5f63ef1437a5b4d473a0ce039b999e30080ef36" => :mavericks
  end

  def install
    Dir.chdir "propro-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
