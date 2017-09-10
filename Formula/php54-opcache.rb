require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Opcache < AbstractPhp54Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://github.com/zend-dev/ZendOptimizerPlus"
  url "https://github.com/zendtech/ZendOptimizerPlus/archive/v7.0.5.tar.gz"
  sha256 "2654d9611e386cc59887d4e8cfba2c010ed4480c7c9c5094ad99fdcf858d94ee"

  head "https://github.com/zendtech/ZendOptimizerPlus.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "4b9cc3a0729952ff83063e8300232f0df97e046f0bf887d72de8b9345bb5ccb1" => :el_capitan
    sha256 "24ba09157df24050a723c3888c32009ae76634e1f3eb0b622626de23bcbb6e68" => :yosemite
    sha256 "4cc160ea8cd1f1f3a7b11411e22ca946121310b65cb3cbf734b4208dbc46a43a" => :mavericks
  end

  depends_on "pcre"

  def extension_type
    "zend_extension"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
