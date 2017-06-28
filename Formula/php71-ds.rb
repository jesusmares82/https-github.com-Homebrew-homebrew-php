require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ds < AbstractPhp71Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/extension"
  url "https://github.com/php-ds/extension/archive/v1.1.10.tar.gz"
  sha256 "9b2ec039dc7140ad7e2bce782b65e2cd04d2f44b10e307beef1465f20e9e6da6"
  head "https://github.com/php-ds/extension.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ea35ef08909a2f3a1dcc4ebb40b0fa5f54f538f6410966217775ee4b4fff5688" => :sierra
    sha256 "cd68e5c855d73851f6509aa94a6b70aae77e3389b73bda5a53e4683d77eb8161" => :el_capitan
    sha256 "20a0e6a02265d0a32aa1214466c7adfa1845a367f80ffe8fd7fed2a2c9bb3b70" => :yosemite
  end

  def install
    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"

    prefix.install "modules/ds.so"
    write_config_file if build.with? "config-file"
  end
end
