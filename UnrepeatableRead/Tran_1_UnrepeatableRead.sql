use DBMS_09
go

exec TX_xem_CTDH @MaDH = 8, @MaSP = 9

select * from CHITIETDONHANG where MaDH = 8 and MaSP = 9
update CHITIETDONHANG set SoLuong = 25 where MaDH = 8 and MaSP = 9