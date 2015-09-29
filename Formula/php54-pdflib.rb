require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pdflib < AbstractPhp54Extension
  init
  desc "Creating PDF on the fly with the PDFlib library"
  homepage "http://www.pdflib.com"
  url "https://pecl.php.net/get/pdflib-3.0.4.tgz"
  sha256 "18de7bf00983a5b0fbbd4f7e993ecf948217072ae6ebff9fbb0eef88b8984b7e"

  bottle do
    cellar :any
    sha256 "0b4a2cad5822974db5aa768f050fe71d1bc0b1fd5c06e39095f2166d1dbf0a6c" => :el_capitan
    sha256 "345dee0b210bb7572c3d975a982eb7a2e9ece97d310fcafddf32984df54bd1b0" => :yosemite
    sha256 "2847489162a872c9852846ecdbdc2fe00b81f9791bcfa03e7496ad6eca263e5f" => :mavericks
  end

  depends_on "pdflib-lite"

  def extension
    "pdf"
  end

  def install
    Dir.chdir "pdflib-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-pdflib=#{Formula["pdflib-lite"].opt_prefix}"
    system "make"
    prefix.install "modules/pdf.so"
    write_config_file if build.with? "config-file"
  end
end
