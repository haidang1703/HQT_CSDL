use DBMS_09
go
-------------------------------------------------------
--Lúc đầu số lượng của sản phẩm A trong chi tiết đơn hàng X thành 20
--Transaction 1: Tài xế xem lại chi tiết đơn hàng thì thấy số lượng sản phẩm là 10. 
create procedure TX_xem_CTDH
	@MaDH nvarchar(10),
	@MaSP nvarchar(10)
as
begin tran 
    if not exists (select * from CHITIETDONHANG where @MaDH = MaDH)
    begin
        raiserror (N'Đơn hàng không tồn tại', 10, 1);
		rollback tran
    end

	else
	begin
		if not exists (select * from CHITIETDONHANG where @MaSP = MaSP)
		begin
			raiserror (N'Sản phẩm không tồn tại', 10, 1);
			rollback tran
		end

		else
		begin
			select * from CHITIETDONHANG where MaDH = @MaDH and MaSP = @MaSP
			waitfor delay '00:00:10'
			select * from CHITIETDONHANG where MaDH = @MaDH and MaSP = @MaSP
			commit tran
		end
	end
go

--Transaction 2: Khách hàng sửa số lượng của sản phẩm A trong chi tiết đơn hàng X thành 10
create procedure KH_capnhat_SL
	@MaDH nvarchar(10),
	@MaSP nvarchar(10),
	@SoLuong int
as
begin tran 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
    if not exists (select * from CHITIETDONHANG where @MaDH = MaDH)
    begin
        raiserror (N'Đơn hàng không tồn tại', 10, 1);
		rollback tran
    end

	else
	begin
		if not exists (select * from CHITIETDONHANG where @MaSP = MaSP)
		begin
			raiserror (N'Sản phẩm không tồn tại', 10, 1);
			rollback tran
		end

		else
		begin
			update CHITIETDONHANG
			set SoLuong = @SoLuong
			where MaDH = @MaDH and MaSP = @MaSP
			commit tran
		end
	end
go