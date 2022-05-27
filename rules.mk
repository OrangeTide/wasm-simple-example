all::
clean::
clean-all::
.PHONY: all clean clean-all
%.o: %.c ; $(compile.c)
%: %.o ; $(link.o)
%: %.c ; $(link.c)
.SECONDEXPANSION:
all:: $$(addsuffix $(EXT),$$(TARGETS))
clean:: $$(addprefix clean-,$$(TARGETS))
clean-all:: clean ; $(RM) $(addsuffix $(EXT),$(TARGETS))
clean-%: ; $(RM) $(patsubst %.c,%.o,$($*_SRCS))
$(addsuffix $(EXT),$(TARGETS)): $$(patsubst %.c,%.o,$$($$(patsubst %$(EXT),%,$$@)_SRCS)) ; $(link.o)
ifneq ($(EXT2),)
all:: $$(addsuffix $(EXT2),$$(TARGETS))
clean-all:: ; $(RM) $(addsuffix $(EXT2),$(TARGETS))
endif
