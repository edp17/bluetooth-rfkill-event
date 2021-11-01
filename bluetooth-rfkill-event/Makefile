OBJS = bluetooth_rfkill_event.o

CFLAGS = -O2 -Wall -Werror
CFLAGS += `pkg-config --cflags bluez`
CFLAGS += `pkg-config --cflags glib-2.0`

LIBS += `pkg-config --libs bluez`
LIBS += `pkg-config --libs glib-2.0`

ifeq ($(RFKILL_HELPER_PATH),)
	RFKILL_HELPER_PATH = /usr/share/libexec/bluetooth_rfkill_event
endif

CFLAGS += -DRFKILL_HELPER_PATH="\"$(RFKILL_HELPER_PATH)\""

%.o: %.c
		$(CC) $(CFLAGS) -c $< -o $@

bluetooth_rfkill_event:     $(OBJS)
		$(CC) $(LDFLAGS) $(OBJS) $(LIBS) -o $@

clean:
		$(RM) $(OBJS) bluetooth_rfkill_event

all: bluetooth_rfkill_event

install:
	mkdir -p $(INSTALL_ROOT)/usr/sbin
	install bluetooth_rfkill_event $(INSTALL_ROOT)/usr/sbin
	mkdir -p $(INSTALL_ROOT)/usr/lib/systemd/system
	install bluetooth-rfkill-event.service $(INSTALL_ROOT)/usr/lib/systemd/system
	mkdir -p $(INSTALL_ROOT)/usr/lib/systemd/system/network.target.wants
	ln -s ../bluetooth-rfkill-event.service $(INSTALL_ROOT)/usr/lib/systemd/system/network.target.wants/bluetooth-rfkill-event.service
	mkdir -p $(INSTALL_ROOT)/etc/bluetooth-rfkill-event
	mkdir -p $(INSTALL_ROOT)/etc/sysconfig
	install bluetooth-rfkill-event.sysconfig $(INSTALL_ROOT)/etc/sysconfig/bluetooth-rfkill-event
	mkdir -p $(INSTALL_ROOT)$(RFKILL_HELPER_PATH)
	install -m 775 killall-wait.sh $(INSTALL_ROOT)$(RFKILL_HELPER_PATH)/killall-wait.sh
