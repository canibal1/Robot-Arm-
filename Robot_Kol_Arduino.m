clear
clc
a=arduino('Com4'); %arduinonun kendisinin çağırılması ve portunun tanımlanması 
say=0;
data=0;
dat=0;
delay=.001;% güncelleme yapmak için gerekli olan  süre

while (1)
kolUzunlugu = 30;
potAnRead = readVoltage(a,'A0'); %pot üzerinden analog okuma gerçekleştirilir.
potAnRead1 = readVoltage(a,'A2');
potAnRead2 = readVoltage(a,'A4');

dat=interp1([0, 5],[0, 270], potAnRead);% interp1 analog olarak aldığı 5 voltu 360 ayrı parçaya bölüyor
                                        %   ve pot dönerken tam tur 360
                                        %   derece döndürmüş oluyor
dat1=interp1([0, 5],[0, 270], potAnRead1);
dat2=interp1([0, 5],[0, 270], potAnRead2);
say=say+1; % açıları değiştirdiğimizde yeni açının yeniden data'ya kayıt edilmesi amaçlı olarak kullanılmıştır.

data(say)=dat(1);  %'data'lar dereceye döndürülmüş analog bilginin diziler halinde saklanmasını sağlar
data1(say)=dat1(1);
data2(say)= dat2(1);
%numaralandırmalarına ve yanlarında yazan 'ucu' ve 'başı' etiketlerine göre
%strokeların (x,y) ekseninde başlangıç ve bitiş noktaları. cosd sind
%derece cinsinden ayarlandı.
%1. strokedan itibaren, bir sonraki stroğun açısına bir öncekinin açısı
%eklenerek örn:("cosd(dat+dat1+dat2) 3. stroke açısı")strokeların analog olarak verilen
%açılarda doğru pozisyon ve açıda kalmaları sağlanmıştır.
x(1) = 0;%x başı 1
y(1) = 0;%y başı 1
x(2) = x(1) + kolUzunlugu * cosd(dat);%x ucu 1
y(2) = y(1) + kolUzunlugu * sind(dat);%y ucu 1
x(3) = x(2);%x başı 2
y(3) = y(2);%y başı 2
x(4) = x(3) + kolUzunlugu * cosd(dat+dat1);%x ucu 2
y(4) = y(3) + kolUzunlugu * sind(dat+dat1);%y ucu 2
x(5) = x(4);%x başı 3
y(5) = y(4);%y başı 3
x(6) = x(5) + kolUzunlugu * cosd(dat+dat1+dat2);%x ucu 3
y(6) = y(5) + kolUzunlugu * sind(dat+dat1+dat2);%y ucu 3
hold off; % çizgiler iz bırakmasın diye kapattım


plot(x, y,'g','LineWidth',2,'MarkerEdgeColor','r','MarkerFaceColor','y','MarkerSize',12); %x ve y eksenlerini çizdiren komut
xlim([-100 100]);% eksen limitleri
ylim([-100 100]); %eksen limitleri
grid on;
pause(delay);% güncellemek için kullanılan satır

end
