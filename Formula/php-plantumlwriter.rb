class PhpPlantumlwriter < Formula
  desc "Create UML diagrams from your PHP source"
  homepage "https://github.com/davidfuhr/php-plantumlwriter"
  url "https://github.com/davidfuhr/php-plantumlwriter/archive/1.6.0.tar.gz"
  sha256 "e0ee6a22877b506edfdaf174b7bac94f5fd5b113c4c7a2fc0ec9afd20fdc0568"

  depends_on "plantuml"
  depends_on "composer" => :build

  def install
    system "composer", "update"

    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/php-plantumlwriter"
  end

  test do
    (testpath/"testClass.php").write <<-EOS.undent
      <?php
      class OneClass
      {
      }
    EOS

    (testpath/"testClass.puml").write <<-EOS.undent
      @startuml
      class OneClass {
      }
      @enduml
    EOS
    system "#{bin}/php-plantumlwriter write testClass.php > output.puml"
    system "diff", "-u", "output.puml", "testClass.puml"
  end
end
