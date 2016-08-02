require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ds < AbstractPhp70Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/extension"
  url "https://github.com/php-ds/extension/archive/v1.0.4.tar.gz"
  sha256 "4cdad2bba1cae18f1196346913ac9a54a23f2e5874fd8678200f88730b2788c6"
  head "https://github.com/php-ds/extension.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5b47e178c446b9663a03911e449fe4eb62a6dc86554d4f4dceff40cbf200ac97" => :el_capitan
    sha256 "92ec724d8be0130f88be81258ecd014765dd9324d56331c857a595422b7ace82" => :yosemite
    sha256 "957a3546f6826401babd464ca9b6a63fbadf5f53f65c11f9f82de49ce274eba6" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"

    prefix.install "modules/ds.so"
    write_config_file if build.with? "config-file"
  end
end
