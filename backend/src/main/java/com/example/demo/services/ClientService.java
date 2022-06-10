package com.example.demo.services;

import com.example.demo.config.JwtTokenUtil;
import com.example.demo.dto.ClientDTO;
import com.example.demo.model.Client;
import com.example.demo.repository.ClientRepository;
import com.example.demo.utils.CustomCopy;
import com.example.demo.vo.ClientsQueryVO;
import com.example.demo.vo.ClientsUpdateVO;
import com.example.demo.vo.ClientsVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class ClientService {
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Autowired
    private ClientRepository clientRepository;

    public Long save(ClientsVO vO, HttpServletRequest httpServletRequest) {
        String token = httpServletRequest.getHeader("Authorization");
        token = token.substring(6);
        String userRole = jwtTokenUtil.getRoleFromToken(token);
        Client bean = new Client();
        BeanUtils.copyProperties(vO, bean);
        if(userRole.equals("accountant") || userRole.equals("manager")){
            bean.setEnabled(true);
        }
        if(userRole.equals("agent"))
            bean.setEnabled(false);
        System.out.println("save clients save by "+userRole);
        bean = clientRepository.save(bean);
        return bean.getIdClient();
    }

    public void delete(Long id) {
        clientRepository.deleteById(id);
    }

    public void update(Long id, ClientsUpdateVO vO) {
        Client bean = requireOne(id);
        CustomCopy.myCopyProperties(vO,bean);
        clientRepository.save(bean);
    }

    public ClientDTO getById(Long id) {
        Client original = requireOne(id);
        return toDTO(original);
    }
    public List<ClientDTO> getAll(){
      return   clientRepository.findAll().stream().map(element->toDTO(element)).collect(Collectors.toList());
    }
    public List<ClientDTO> getAllEnabled(boolean enabled){
        return  clientRepository.findAllByEnabled(enabled).stream().map(element->toDTO(element)).collect(Collectors.toList());
    }
    public void updateEnable(Long id){
        Client original = requireOne(id);
        original.setEnabled(true);
        clientRepository.save(original);
    }
    public Page<ClientDTO> query(ClientsQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private ClientDTO toDTO(Client original) {
        ClientDTO bean = new ClientDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    public Client requireOne(Long id) {
        return clientRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
}
