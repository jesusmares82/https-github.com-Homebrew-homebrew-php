require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Propro < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/propro"
  url "https://pecl.php.net/get/propro-1.0.0.tgz"
  sha256 "9825d50ab4bb214428cd11c14c2f389c16aded09db16d266f27f147a7f2371f2"

  head "https://git.php.net/repository/pecl/php/propro.git"

  bottle do
    sha256 "64e5657af7aef4b229bba1e1be545d43c9cd6c4b9fe9a73ed4298ced332b49f0" => :yosemite
    sha256 "d440aadd47ba90ae7f4657fc1fd28c8ac4e2635b734a749ce34adb7140cf358f" => :mavericks
    sha256 "fb1591287c760a949d8aa68a0d8a192b33afff41f90b8a4952d6a769b9b5739e" => :mountain_lion
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
