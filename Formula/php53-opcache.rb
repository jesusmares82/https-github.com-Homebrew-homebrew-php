require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Opcache < AbstractPhp53Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://github.com/zend-dev/ZendOptimizerPlus"
  url "https://github.com/zendtech/ZendOptimizerPlus/archive/v7.0.5.tar.gz"
  sha256 "2654d9611e386cc59887d4e8cfba2c010ed4480c7c9c5094ad99fdcf858d94ee"

  head "https://github.com/zendtech/ZendOptimizerPlus.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "32f010cc6a07a68b69e7893667a75cbc59a43398838cddcb8d410827702fd893" => :el_capitan
    sha256 "96fa030c46787e16e38674180a95a6c6ed11647c72becf764c33ac2cf34bedd2" => :yosemite
    sha256 "bc0165eb5840f5c86d40372ff7a4284bcf5efde224a7ca3d970c5f88d57022d0" => :mavericks
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
