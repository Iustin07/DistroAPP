package com.example.demo.controller;

import com.example.demo.dto.CentralizerDTO;
import com.example.demo.model.Centralizer;
import com.example.demo.model.CustomCentralizer;
import com.example.demo.services.CentralizerService;
import com.example.demo.vo.CentralizersQueryVO;
import com.example.demo.vo.CentralizersUpdateVO;
import com.example.demo.vo.CentralizersVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;
import java.util.List;

@Validated
@RestController
@RequestMapping("/centralizers")
public class CentralizerController {

    @Autowired
    private CentralizerService centralizerService;

    @PostMapping
    public String save(@Valid @RequestBody CentralizersVO vO) {
        return centralizerService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        centralizerService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody CentralizersUpdateVO vO) {
        centralizerService.update(id, vO);
    }
    @GetMapping("/driver")
    public List<CentralizerDTO> getByDateAndDriver(@RequestParam("date")String date, HttpServletRequest httpServletRequest){
        return centralizerService.getByDateAndDriver(date,httpServletRequest);
    }
    @GetMapping("/{id}")
    public CentralizerDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return centralizerService.getById(id);
    }
    @GetMapping("/all")
    public List<CentralizerDTO> getAll(){
        return centralizerService.getAll();
        }
    @GetMapping("/summarize/{id}")
    public List<CustomCentralizer> getSummarize(@Valid @NotNull @PathVariable("id") Long id){
        return centralizerService.getSummarize(id);
    }
    @PostMapping("/generate")
    ResponseEntity<Object> generateCentralizers(@RequestParam("date")String date){
        return centralizerService.getGeneratedCentralizers(date);
    }
    @GetMapping("specific")
    List<CentralizerDTO> getByDate(@RequestParam("date")String date){
        LocalDate convertedDate=LocalDate.parse(date);
        return centralizerService.getBydate(convertedDate);
    }
    @GetMapping
    public List<CentralizerDTO> query(@Valid CentralizersQueryVO vO) {
        return centralizerService.query(vO);
    }
}
