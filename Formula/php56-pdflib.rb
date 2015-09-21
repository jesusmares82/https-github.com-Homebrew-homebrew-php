require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pdflib < AbstractPhp56Extension
  init
  homepage "http://www.pdflib.com"
  url "https://pecl.php.net/get/pdflib-3.0.4.tgz"
  sha256 "18de7bf00983a5b0fbbd4f7e993ecf948217072ae6ebff9fbb0eef88b8984b7e"

  bottle do
    cellar :any
    sha256 "c9e05e92916409e8e95f56b367e6ca257336dd89dda1a5823b4484b057606207" => :el_capitan
    sha256 "ed5d4c824aa2378344715d9b995cd1099a089569cf222a92a167e6ebb942b909" => :yosemite
    sha256 "a53671e284be43cb602fb3c7dd3ab01a0f97e5214ea50c0008f040e4a375eb0f" => :mavericks
  end

  depends_on "pdflib-lite"

  def install
    Dir.chdir "pdflib-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/pdf.so"
    write_config_file if build.with? "config-file"
  end
end
