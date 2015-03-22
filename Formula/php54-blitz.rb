require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Blitz < AbstractPhp54Extension
  init
  homepage 'http://alexeyrybak.com/blitz/blitz_en.html'
  url 'https://github.com/alexeyrybak/blitz/archive/v0.8.18.tar.gz'
  sha1 'c51233a241943faf74c6d28622277ff26d299cb8'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "a239b84f9dacb96cd67a24ed7e15c91534c613c46237b87a8322395260d305fc" => :yosemite
    sha256 "d36a18cce0b2a6d35f48fe783919d0aee8b250a947e9ecebcb3de0ddacc87a45" => :mavericks
    sha256 "ce33d14a54ba1d7bd58b73df0db148b1339949931067829b3a6fefa4974025f9" => :mountain_lion
  end

  head 'https://github.com/alexeyrybak/blitz.git'

  def install
    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/blitz.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent
      blitz.auto_escape=0
      blitz.check_recursion=1
      blitz.comment_close="*/"
      blitz.comment_open="/*"
      blitz.enable_alternative_tags=1
      blitz.enable_callbacks=1
      blitz.enable_comments=0
      blitz.enable_include=1
      blitz.enable_php_callbacks=1
      blitz.lower_case_method_names=1
      blitz.path=""
      blitz.php_callbacks_first=1
      blitz.remove_spaces_around_context_tags=1
      blitz.scope_lookup_limit=0
      blitz.tag_close="}}"
      blitz.tag_close_alt="-->"
      blitz.tag_open="{{"
      blitz.tag_open_alt="<!--"
      blitz.throw_exceptions=0
      blitz.var_prefix="$"
      blitz.warn_context_duplicates=0
    EOS
  end
end
