# OyunProje1
2D Platform Oyun Projesi

Godot oyun geliştirme motorunun yazılım dili olan GDScript i kullandım. Önce GameManager adında bir kod dizimi oluşturdum. Bu kodda oyuncunun canı, toplanan elmas ve kiraz miktarlarını tutuyor onları diğer kodlara yönlendiriyorum. Ardından oyuncunun kodunu oluşturdum ve fizik, oyuncunun kontrolü, animasyonlar, ölüm gibi mekanikleri kodladım. Bu kodlardan bazılarına örnek:
Godot oyun geliştirme motorunun yazılım dili olan GDScript i kullandım. Bu kodlardan bazılarına örnek:

bat.gd – Yarasa Düşmanı
• _physics_process(): Yarasa sürekli ileri uçar, sinüsle yukarı-aşağı süzülür.
• _on_timer_timeout(): Süre dolunca yön değiştirir (x yönü ters çevrilir).
• _on_area_2d_body_entered(body): Üstten vurulursa ölür, yoksa oyuncuya zarar verir (knockback).
• die(): Ölüm animasyonu başlatır ve yok eder.

cherry.gd – Kiraz (Toplanabilir)
• _on_area_entered(body): Oyuncuya çarpınca animasyon oynar, kiraz sayısını GameManagerda değeri artırır ve kendini yok eder.

control.gd – Can UI

• update_lives(lives): Mevcut cana göre kalp ikonlarını dolu/boş yapar.

door.gd – Kapı
• _ready(): GameManager'dan ID’yi kontrol eder, açıksa animasyonla kapıyı açar (CollisionShape kapatılır).
• open(): Animasyonu oynatır ve engelleri devre dışı bırakır.

eagle.gd – Kartal Düşman
• _physics_process(): Kartal dikey hareket eder (sinüsle).
• _on_timer_timeout(): Süre dolunca yön değiştirir.
• _on_area_2d_body_entered(body): Üstten vurulursa ölür, yoksa oyuncuya zarar verir (knockback).
• die(): Üstten vurulursa ölür, yoksa oyuncuya zarar verir (knockback).

ending.gd – Bitiş Ekranı
• _ready(): GameManager’dan alınan istatistikleri yazıya döker.
• calculate_rank(): Toplanan taş ve kiraza göre puan hesaplar, harf notu verir.

feedback.gd – Toplama Efekti
• show_feedback(text, pos): Belirli pozisyonda yazıyı gösterip kısa animasyonla kaybolur.

frog.gd – Kurbağa Düşman
• _ready(): Zıplama zamanlayıcısını başlatır.
• _on_timer_timeout(): Süre dolunca kurbağa sıçrar ve yön değiştirir.
• _on_area_2d_body_entered(body): Üstten vurulursa ölür, yoksa oyuncuya zarar verir (knockback).

fullscreencontrol.gd – Tam Ekran Ayarı
• _on_check_button_toggled(button_pressed): Buton açıksa tam ekran yapar, değilse pencere moduna döner.

GameManager.gd – Oyun Yöneticisi 
• Değişkenler: Can, taş, kiraz sayısı, açılan kapılar.
• take_damage(): Can azaltır, sıfırsa oyuncuyu öldürür.
• add_gem/cherry(): Sayıları artırır ve sinyal yollar.
• open_door(id): Kapı ID'sini açık listeye ekler.
• Sinyaller: UI ve diğer sistemlere haber verir.

gem.gd – Taş (Toplanabilir)
• _on_area_entered(body): Oyuncuya temasla GameManager'a taş ekletir, efekt oynatır, yok olur.

invincibilitycontrol.gd – Yenilmezlik
• _on_check_button_toggled(): Açıldığında canı 999 yapar, kapandığında 3'e döner.

key.gd – Anahtar
• _on_area_entered(body): GameManager’da ilgili kapıyı açar, anahtar kaybolur.

main_menu.gd – Ana Menü
• on_play_button_pressed(): Oyunu başlatır.
• on_settings_button_pressed(): Ayarları açar.
• on_quit_button_pressed(): Oyunu kapatır.

slider.gd – Ses Kontrolü
• on_value_changed(value): Seçilen ses kategorisinin ses seviyesini değiştirir.

opossum.gd – Opossum Düşman
• _physics_process(): Yatay yürür, yönünü sprite ile birlikte değiştirir.
• on_timer_timeout(): Süre dolunca yön değiştirir.
• _on_area_2d_body_entered(body): Üstten vurulursa ölür, değilse oyuncuya zarar verir.

player.gd – Oyuncu
• Hareket, zıplama, tırmanma ve animasyon kontrolü.
• take_damage(): Can azaltır, invincibility varsa hasar yemez.
• knockback(): Geri savrulma efekti.
• die(): Ölüm animasyonu, ardından sahneyi yeniden yükler.

ui.gd – Oyun UI
• Sinyallerle taş ve kiraz sayılarını alır ve Label'ları günceller.

