require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Grpc < AbstractPhp56Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.2.0.tgz"
  sha256 "df205473888ad711e6c49df51732afee3e4fbcdd8dd717497531b733b22dd4ac"

  bottle do
    cellar :any_skip_relocation
    sha256 "aade66c9752edf586090346f82e13ac919093fdddd322107a651a8baaa45ce9f" => :sierra
    sha256 "cdde3191cd43371eeddd9f1235c2e956aad1b416328c8ed7e751d8955ffbabee" => :el_capitan
    sha256 "dba307f94b9a3f8500e68a490b8886b1a6bc6cfef29d7c4685244791da93699a" => :yosemite
  end

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc=#{HOMEBREW_PREFIX}",
           "--prefix=#{prefix}", phpconfig,
           "CFLAGS=-Ithird_party/boringssl/include"
    system "make"
    prefix.install "modules/grpc.so"
    write_config_file if build.with? "config-file"
  end
end
