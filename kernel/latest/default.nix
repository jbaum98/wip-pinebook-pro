{ pkgs, lib, linux_5_10, kernelPatches, ... } @ args:

linux_5_10.override({
  kernelPatches = lib.lists.unique (kernelPatches ++ [
    pkgs.kernelPatches.bridge_stp_helper
    pkgs.kernelPatches.request_key_helper
    {
      name = "pinebookpro-5.10.patch";
      patch = ./pinebookpro-5.10.patch;
    }
    {
      name = "0001-HACK-Revert-pwm-Read-initial-hardware-state-at-reque.patch";
      patch = ./0001-HACK-Revert-pwm-Read-initial-hardware-state-at-reque.patch;
    }
    {
      name = "pinebookpro-config-fixes";
      patch = null;
      extraConfig = ''
        PCIE_ROCKCHIP y
        PCIE_ROCKCHIP_HOST y
        PCIE_DW_PLAT y
        PCIE_DW_PLAT_HOST y
        PHY_ROCKCHIP_PCIE y
        PHY_ROCKCHIP_INNO_HDMI y
        PHY_ROCKCHIP_DP y
        ROCKCHIP_MBOX y
        STAGING_MEDIA y
        VIDEO_HANTRO m
        VIDEO_HANTRO_ROCKCHIP y
        USB_DWC2_PCI y
        ROCKCHIP_LVDS y
        ROCKCHIP_RGB y
      '';
    }
  ]);
})
//
(args.argsOverride or {})
