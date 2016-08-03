require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ds < AbstractPhp71Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/extension"
  url "https://github.com/php-ds/extension/archive/v1.0.4.tar.gz"
  sha256 "4cdad2bba1cae18f1196346913ac9a54a23f2e5874fd8678200f88730b2788c6"
  head "https://github.com/php-ds/extension.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "04dac6de3ee3608d8259f91b644521b3d138dd0de7015cdcc43f7e4cefef4e2d" => :el_capitan
    sha256 "f0faa432ab03882252689c1fe66ae40b4e35dce2d26a0ffdff0017c070594941" => :yosemite
    sha256 "823c0cc5bac9b0d0935435d391e2f6718a85e3fa4b4df84313abf6621afb846c" => :mavericks
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
