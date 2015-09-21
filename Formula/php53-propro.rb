require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Propro < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/propro"
  url "https://pecl.php.net/get/propro-1.0.0.tgz"
  sha256 "9825d50ab4bb214428cd11c14c2f389c16aded09db16d266f27f147a7f2371f2"

  head "https://git.php.net/repository/pecl/php/propro.git"

  bottle do
    sha256 "57911ef05e745a3787c4423b2f9b2d952249e55530da84409638dd29afd477d1" => :yosemite
    sha256 "722c9dbcfc642bc23b53763a1224d75afa01fe20327d49e969bc16f7c0dd759c" => :mavericks
    sha256 "94b9412e169fe7eb3df328f60bc68c2675584d46bb03bbb075ad50747952a304" => :mountain_lion
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
